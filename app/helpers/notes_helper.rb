module NotesHelper
  def fetch_notes_for_url(url)
    notes = MetaNote.get_by_subject_url(url,100).order("created_at desc")
    json = notes.map { |note| question.to_json}
  end
end