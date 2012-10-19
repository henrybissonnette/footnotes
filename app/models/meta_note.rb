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

  def self.get_recent(limit = 10)
    recent_meta = self.includes(:note).order("created_at desc").limit(limit)
    convert_metas_to_notes!(recent_meta)
    recent_meta
  end

  def self.get_by_user(user_id, limit = 10)
    by_user_meta = self.includes(:note).where('creator_id = ?',user_id).order("created_at desc").limit(limit)
    convert_metas_to_notes!(by_user_meta)
    by_user_meta
  end

  def self.convert_metas_to_notes!(meta_array)
    meta_array.map! do |meta|
      meta.note.to_json
    end    
  end

end
