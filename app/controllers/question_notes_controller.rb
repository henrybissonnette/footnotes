class QuestionNotesController < ApplicationController

  def create
    note = QuestionNote.new
    note.title = params['title']
    note.content = params['content']
    note.subject_url = CGI::unescape(params['external_url'])
    note.creator_id = current_user ? current_user.id : nil
    note.save
    note.created_at = params['createdAt']
    if params['parentID']
      note.parent = MetaNote.find(params['parentID']).note
    end
    note.save
    render json: note.to_json
  end

  def destroy
    id = params['id']
    meta = MetaNote.find id
    meta.note.destroy
    render text: 'destroyed'
  end

  def update
    id = params['id']
    meta = MetaNote.find id
    note = meta.note
    note.title = params['title']
    note.content = params['content']
    note.save
    render json: note.to_json
  end

  def index
    @external_url = params['external_url']
    questions = QuestionNote.joins(:meta).where(:meta_notes =>{:subject_url => @external_url}).order("created_at desc")
    json = questions.map { |question| question.to_json}

    render json: json
  end  
end