class MetaNote < ActiveRecord::Base
  attr_accessible :creator_id, :note_id, :note_type, :parent_id, :subject_url, :title
  belongs_to :note, :polymorphic => true
  belongs_to :creator, :class_name => 'User' 
  belongs_to :parent, :class_name => 'MetaNote'
  has_many :children, :class_name => 'MetaNote',:foreign_key => 'parent_id'
  validates :subject_url, :presence => true

  def creator_name
    creator ? creator.username : 'anonymous'
  end

  def count_descendants(first = true)
    #TODO replace this with a version that doesnt suck
    count = first ? 0 : 1
    children.each do |child| 
      count += child.count_descendants(false)
    end    
    count 
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

  def self.get_by_subject_url(subject_url, limit = 100)
    by_subject_meta = self.where(subject_url: subject_url).order("created_at desc").limit(limit)
    puts by_subject_meta.to_yaml
    convert_metas_to_notes!(by_subject_meta)
    by_subject_meta
  end

  def self.convert_metas_to_notes!(meta_array)
    meta_array.map! { |meta| meta.note.to_json }
  end
end
