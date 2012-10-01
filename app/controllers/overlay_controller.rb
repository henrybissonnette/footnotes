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
    if params[:from_click] != 'true'     
      @doc = Nokogiri::HTML(open(@external_url))
      @doc.css('a').each do |link|
        link['href'] = localize_link(link['href'])
      end
      @doc.to_html
    end

    render text: @doc
  end

  private
  # TODO move all of this work into class in lib
  def resolve_layout
    case action_name
    when "proxy"
      false
    else
      "application"
    end
  end

  def localize_link(href)
    begin 
      domain = @external_url.match(%r"^((?:https?://)?[A-Za-z\d\-.]+)(?:/)?")[1]
    rescue NoMethodError
     raise ArgumentError, "could not match domain in url #{@external_url}"
    end
    pre_string = '/overlay/proxy?from_click=true&external_url='

    destination = case href
    when %r"https?://.*"
      href
    when %r"//.*"
      href[2..-1]
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