class QuestionNotesController < ApplicationController

  def create
    note = QuestionNote.new
    note.content = params['content']
    note.subject_url = params['external_url']
    note.title = params['title']
    note.creator_id = current_user ? current_user.id : nil
    note.save
    render json: note.to_json
  end

  def index
    @external_url = params['external_url']
    questions = QuestionNote.joins(:meta).where(:meta_notes =>{:subject_url => @external_url})
    json = questions.map { |question| question.to_json}

    render json: json
  end  

end