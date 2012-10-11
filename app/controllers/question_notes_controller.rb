class QuestionNotesController < ApplicationController

  def create
    note = QuestionNote.new
    note.content = params['content']
    note.set_meta
    note.meta.subject_url = params['subject_url']
    note.meta.title = params['title']
    note.meta.creator_id = current_user ? current_user.id : nil
    note.save
    json = ActiveSupport::JSON.encode(note)
    render json: note
  end

end