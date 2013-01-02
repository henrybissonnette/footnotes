class NotesForUrlController < ActionController::Base
  layout false

  def view
    @focusID = params['focusID']
    @from_extension = params['from_extension']
    @notes = get_notes
    begin
      @topic = params[:external_url].match(%r{.*/([^/]+)/?})[1]
    rescue 
      @topic = nil
    end
  end

  def get_notes(number = 100)
    MetaNote.get_by_subject_url(params[:external_url],number)
  end
end