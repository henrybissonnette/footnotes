require 'nokogiri'
require 'open-uri'
require 'html_link_localizer'

class OverlayController < ApplicationController
  before_filter :init
  layout :resolve_layout

  def init
    @from_click = params[:from_click]
    @external_url = params[:external_url]
  end

  def view
    @notes = get_notes
    begin
      @topic = @external_url.match(%r{.*/([^/]+)/?})[1]
    rescue 
      @topic = nil
    end
  end

  def proxy
    document = ''
    begin
      if @from_click != 'true'     
        localizer =  HtmlLinkLocalizer.new(
          '/overlay/proxy?from_click=true&external_url=',
          @external_url
          )
         document = localizer.get_localized_html
      end
      render text: document
    rescue SocketError, URI::InvalidURIError
      redirect_to "/overlay/proxy?from_click=true&overlay_fail=#{@external_url}"
    end
  end

  private

  def get_notes(number = 10)
    MetaNote.get_by_subject_url(@external_url,number)
  end

  def resolve_layout
    case action_name
    when "view"
      "application"
    else
      false
    end
  end
end