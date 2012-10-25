require 'nokogiri'
require 'open-uri'
require 'uri'

class HtmlLinkLocalizer
  attr_accessor :html

  def initialize(local_url,external_url)
    @input_html = html
    @local_url = local_url
    @external_url = add_http(external_url)
    puts "external url is: #{@external_url}"
  end

  def get_localized_html
    @source = fetch_source

    each_href do |uri|
      localize_href(uri)
    end
    each_resource do |uri|
      make_absolute(uri)
    end

    @source.to_html
  end

  private

  def fetch_source
    external = open(@external_url)
    Nokogiri::HTML(external)
  end

  def is_anchor?(href)
    href[0] == '#'
  end

  def is_relative?(href)
     !!href.match(%r{^/[^/]})
  end

  def has_http?(href)
    !!href.match(%r{^https?://})
  end

  def add_http(href)
    if !is_relative?(href) && !has_http?(href)
      if !(href[0,2] == '//')
        href ='//' + href
      end
      href = 'http:' + href
    end
    href
  end

  def localize_href(href)
      href = make_absolute(href)
      href = add_http(href)
      @local_url + href
  end

  def make_absolute(href)
    if is_relative?(href)
      uri = URI.parse(@external_url)
      href = uri + href
    end
    href.to_s
  end

  def each_href
    @source.css('a').each do |link|
      link['href'] = yield(link['href']) if link['href'] && !is_anchor?(link['href'])
    end
    @source.css('form').each do |form|
      form['action'] = yield(form['action']) if form['action']
    end  
  end

  def each_resource
    @source.css('script').each do |tag|
      tag['src'] = yield(tag['src']) if tag['src']
    end  

    @source.css('link').each do |link|
      link['href'] = yield(link['href']) if link['href']
    end
  end
end