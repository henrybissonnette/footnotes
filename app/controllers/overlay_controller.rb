require 'nokogiri'
require 'open-uri'
require 'html_link_localizer'

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
    document = ''
    if params[:from_click] != 'true'     
      localizer =  HtmlLinkLocalizer.new(
        '/overlay/proxy?from_click=true&external_url=',
        @external_url
        )
       document = localizer.get_localized_html
    end
    render text: document
  end

  private
  def resolve_layout
    case action_name
    when "proxy"
      false
    else
      "application"
    end
  end
end