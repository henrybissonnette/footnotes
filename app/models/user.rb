class User < ActiveRecord::Base
  attr_accessible :email, :username, :identifier_url
end
