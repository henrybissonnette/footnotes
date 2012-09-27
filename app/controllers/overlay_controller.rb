require 'nokogiri'
require 'open-uri'

class OverlayController < ApplicationController
  layout :resolve_layout

  def view
    @external_url = params[:external_url]
    @external_url ||= 'http://en.wikipedia.org/wiki/Apple'
    @topic = @external_url.match(%r{.*/([^/]+)/?})[1]
  end

  def proxy
    @external_url = params[:external_url]
    @external_url ||= 'http://en.wikipedia.org/wiki/Apple'    
    @doc = Nokogiri::HTML(open(@external_url))
    @links = []
    @doc.css('a').each do |link|
      link['href'] = localize_link(link['href'])
    end
    @doc.to_html
  end

  def resolve_layout
    case action_name
    when "proxy"
      false
    else
      "application"
    end
  end

  def localize_link(href)
    domain = @external_url.match(%r"((?:https?://)?[a-z\d.]+)/.*")[1]
    pre_string = '/overlay/proxy?external_url='

    destination = case href
    when %r"//.*"
      href
    when %r"http://.*"
      href
    when %r"/[^/].*"
      domain + href
    when %r"#"
      @external_url + href
    else
      ""
    end
    pre_string + destination
  end
end