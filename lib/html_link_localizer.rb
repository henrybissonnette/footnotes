require 'nokogiri'
require 'open-uri'
require 'uri'

class HtmlLinkLocalizer
  attr_accessor :html

  def initialize(html,local_url,external_url)
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

  def is_relative?(href)
    href.match(%r{^/[^/]}) || href[0] == '#' ? true : false
  end

  def has_http?(href)
    href.match(%r{^https?://}) ? true : false
  end

  def add_http(href)
    if !is_relative?(href) && !has_http?(href)
      if !(href[0,2] == '//')
        href ='//'+href
      end
      href = 'http:'+href
    end
    href
  end

  def localize_href(href)
    href = make_absolute(href)
    @local_url+href
  end

  def make_absolute(href)
    if is_relative?(href)
      uri = URI.new(@external_url)
      href = uri+href
    end
    href
  end

  def each_href
    out = Nokogiri::HTML(open(@external_url))
    out.css('a').each do |link|
      link['href'] = yield(link['href'])
    end
    out.to_html
  end
end