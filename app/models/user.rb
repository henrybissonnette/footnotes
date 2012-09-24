class User < ActiveRecord::Base
  attr_accessible :email, :username, :identifier_url
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :identifier_url
  validates :username, length: {maximum: 50}
  validates :email, presence: true
  validates :identifier_url, presence: true
  
  def has_username? # does console have to be restarted for changes to register?  
    !self.username.nil?
  end
end
