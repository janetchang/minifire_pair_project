class Url < ActiveRecord::Base
  attr_accessible :orig_url, :short_url, :impressions

  validates :orig_url, :format => { :with => /htt(p|ps):\/\/.+[.]/ }
  validates :short_url, :uniqueness => { :is => true }

  belongs_to :user

  scope :without_users, where(:user_id => nil)
  scope :with_users, where('user_id IS NOT NULL')

end