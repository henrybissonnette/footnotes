class Api::NotesController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render :json => fetch_notes_for_url(params['external_url'])
      end
    end
  end

  def fetch_notes_for_url(url)
    notes = MetaNote.get_by_subject_url(url,100)
    json = notes.map { |note| note.to_json}
  end
end