
module FootnoteModule

  def self.included(base)
    base.has_one :meta, 
        :as => :note,
        :class_name => 'MetaNote', 
        :foreign_key => 'note_id',
        :autosave => true,
        :dependent => :destroy
    base.validates_associated :meta
  end

  def initialize
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

  def creator_name
    self.meta.creator_name || 'anonymous'
  end

  def creator_id
    self.meta.creator_id
  end

  def creator_id=(value)
    self.meta.creator_id = value
  end

  def creator
    self.meta.creator
  end

  def children
    self.meta.children.map{|meta| meta.note}
  end

  def note_type=(value)
    self.meta.note_type = value
  end

  def note_type
    self.meta.note_type
  end

  def subject_url=(value)
    self.meta.subject_url = value
  end

  def subject_url
    self.meta.subject_url
  end

  def title
    self.meta.title
  end

  def title=(value)
    self.meta.title = value
  end

  def has_subject_url
    !!self.meta.subject_url
  end

  def parent
    self.meta.parent
  end

  def parent=(note)
    self.meta.parent = note.meta
  end
end