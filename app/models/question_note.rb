class QuestionNote < ActiveRecord::Base
  include FootnoteModule
  attr_accessible :content

  def to_json
    out = {
      id: unique_ID,
      content: content,
      title: title,
      noteType: note_type,
      creatorName: creator_name,
      externalURL: subject_url,
      createdAt: created_at,
      createdAtPretty: created_at.strftime("%m/%d/%y %H:%M"),
      creatorID: creator_id,
      child_IDs: child_IDs, 
      descendantCount: count_descendants,
      parentID: parent_ID
    }
  end
end
