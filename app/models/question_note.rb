class QuestionNote < ActiveRecord::Base
  attr_accessible :content
  has_one :meta, :class_name => 'MetaNote', :foreign_key => 'note_id'
end
