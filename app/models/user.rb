class User < ActiveRecord::Base
  attr_accessible :username
  validates :username, :uniqueness => { :is => true }
  
  has_many :urls
end
