require 'footnote_module'

class QuestionNote < ActiveRecord::Base
  include FootnoteModule
  # receives magic attribute meta from module 
  has_one :meta, :class_name => 'MetaNote', 
        :foreign_key => 'note_id',
        :autosave => true,
        :dependent => :destroy
  attr_accessible :content
  after_create :set_meta
  self.validate :has_subject_url

  def set_meta(attr={})
    if self.meta
      self.meta.update_attributes(attr)
    else
      self.meta = self.build_meta(attr)
    end
    save
  end

  def subject_url
    meta.subject_url
  end

  def has_subject_url
    !!meta.subject_url
  end
end
