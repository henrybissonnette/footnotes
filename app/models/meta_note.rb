class MetaNote < ActiveRecord::Base
  attr_accessible :creator_id, :note_id, :note_type, :parent_id, :subject_url, :title
  belongs_to :note, :polymorphic => true
  belongs_to :creator, :class_name => 'User' 
  belongs_to :parent, :class_name => 'MetaNote'
  has_many :children, :class_name => 'MetaNote',:foreign_key => 'parent_id'
  validates :subject_url, :presence => true

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
    creator ? creator.username : 'anonymous'
  end

  def self.get_recent(number)
    recent_meta = self.includes(:note).order("created_at desc").limit(number)
    recent_meta.map! do |meta|
      meta.note.to_json
    end
    recent_meta
  end

end
