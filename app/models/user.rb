

class User < ActiveRecord::Base
  attr_accessible :email, :username, :identifier_url
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :identifier_url
  # validates :username, length: {maximum: 25}
  # validates :email, presence: true
  # validates :identifier_url, presence: true
  # validates_format_of :username, :with => /\A[\w]*\z/, :message => "may only contain letters, numbers, and underscores"
  has_many :footnotes, :class_name => MetaNote, :foreign_key => 'creator_id'
  
  def has_username? 
    !self.username.nil?
  end

  def to_json
    {
      id: id,
      username: username
    }
  end
end
