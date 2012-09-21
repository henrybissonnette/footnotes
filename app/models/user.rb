class User < ActiveRecord::Base
  attr_accessible :email, :username, :identifier_url
  # TODO validate uniqueness of all
  
  def has_username? # does console have to be restarted for changes to register?  
    !self.username.nil?
  end
end
