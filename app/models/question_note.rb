

class QuestionNote < ActiveRecord::Base
  include FootnoteModule
  has_one :meta, 
        :as => :note,
        :class_name => 'MetaNote', 
        :foreign_key => 'note_id',
        :autosave => true,
        :dependent => :destroy
  attr_accessible :content
  self.validate :has_subject_url

  def initialize(args = nil)
    super
    set_meta
  end

  def set_meta(attr={})
    if self.meta
      self.meta.update_attributes(attr)
    else
      self.meta = self.build_meta(attr)
    end
  end

  def to_json
    out = {
      id: id,
      content: content,
      title: title,
      noteType: note_type,
      creatorName: creator_name,
      externalURL: subject_url
    }
  end

end
