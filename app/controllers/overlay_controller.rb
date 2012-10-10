require 'nokogiri'
require 'open-uri'
require 'html_link_localizer'

class OverlayController < ApplicationController
  before_filter :init
  layout :resolve_layout

  def init
    @from_click = params[:from_click]
    @external_url = params[:external_url]
    @external_url ||= 'http://en.wikipedia.org/wiki/Apple'
  end

  def ajax
    @request = params[:ajax_request]
    if @request  == "init"
      load_footnotes
    end
  end  

  def view
    @topic = @external_url.match(%r{.*/([^/]+)/?})[1]
  end

  def proxy
    document = ''
    if @from_click != 'true'     
      localizer =  HtmlLinkLocalizer.new(
        '/overlay/proxy?from_click=true&external_url=',
        @external_url
        )
       document = localizer.get_localized_html
    end
    render text: document
  end

  private

  def load_footnotes
    question = QuestionNote.new(content: "question content")
    question.set_meta subject_url: @external_url
    question.save
    questions = QuestionNote.joins(:meta).where(:meta_notes =>{:subject_url => @external_url})
    json = ActiveSupport::JSON.encode(questions)
    render json: json
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