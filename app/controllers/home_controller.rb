class HomeController < ApplicationController
  def recent_notes(number)
    MetaNote.get_recent(number)
  end

  def default
    @recent_notes = recent_notes(10)
    @recent_notes.map do |note|
      note.to_json
    end
  end
end 