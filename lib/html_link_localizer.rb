require 'nokogiri'
require 'open-uri'
require 'uri'

class HtmlLinkLocalizer
  attr_accessor :html

  def initialize(local_url,external_url)
    @input_html = html
    @local_url = local_url
    @external_url = add_http(external_url)
  end

  def get_localized_html
    each_href do |href|
      localize_href(href)
    end
  end

  private

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
    # TODO figure out why I cant chain this
    
    external = open(@external_url)
    out = Nokogiri::HTML(external)

    out.css('a').each do |link|
      link['href'] = yield(link['href']) if link['href'] && !is_anchor?(link['href'])
    end
    out.css('form').each do |form|
      form['action'] = yield(form['action']) if form['action']
    end  
    # TODO need to handle resources and forms with relative uris
    out.to_html
  end
end