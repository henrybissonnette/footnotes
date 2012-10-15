class FootnotesController < ApplicationController

  def get_page_notes
    @external_url = params['external_url']
    questions = QuestionNote.joins(:meta).where(:meta_notes =>{:subject_url => @external_url})
    json = questions.map { |question| question.to_json}

    render json: json
  end

end