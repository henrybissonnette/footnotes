class QuestionNote < ActiveRecord::Base
  include FootnoteModule
  attr_accessible :content

  def to_json
    out = {
      id: id,
      content: content,
      title: title,
      noteType: note_type,
      creatorName: creator_name,
      externalURL: subject_url,
      createdAt: created_at,
      createdAtPretty: created_at.strftime("%m/%d/%y %H:%M"),
      creatorID: creator_id
    }
  end
end
