class MetaNote < ActiveRecord::Base
  attr_accessible :creator_id, :note_id, :note_type, :parent_id, :subject_url, :title
  belongs_to :note, :polymorphic => true
  belongs_to :creator, :class_name => 'User' 
  belongs_to :parent, :class_name => 'MetaNote'
  has_many :children, :class_name => 'MetaNote',:foreign_key => 'parent_id'

  def to_json
    {
      note_type: note_type,
      creator: creator.to_json,
      subject_url: subject_url,
      #children: @children.to_json,
      title: title
    }
  end

  def creator_name
    creator.username
  end

end
