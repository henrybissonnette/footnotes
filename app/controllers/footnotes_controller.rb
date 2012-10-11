class FootnotesController < ApplicationController

  def get_page_notes
    subject_url = params['subject_url']
    question = QuestionNote.new(content: "question content")
    question.set_meta subject_url: @external_url
    question.content = "server content" 
    question.save
    questions = QuestionNote.joins(:meta).where(:meta_notes =>{:subject_url => @external_url})
    json = ActiveSupport::JSON.encode(questions)
    render json: json
  end

end