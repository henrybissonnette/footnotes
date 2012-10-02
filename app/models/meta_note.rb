class MetaNote < ActiveRecord::Base
  attr_accessible :creator_id, :note_id, :note_type, :parent_id, :subject_url, :title
  belongs_to :note, :polymorphic => true
  belongs_to :creator, :class_name => 'User' 
  belongs_to :parent, :class_name => 'MetaNote'
  has_many :children, :class_name => 'MetaNote',:foreign_key => 'parent_id'
end
