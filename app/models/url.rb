class Url < ActiveRecord::Base
  attr_accessible :orig_url, :short_url, :impressions, :user_id

  validates :orig_url, :format => { :with => /htt(p|ps):\/\/.+[.]/ }
  validates :short_url, :uniqueness => { :is => true }

  belongs_to :user

  scope :without_users, where(:user_id => nil)
  scope :with_users, where('user_id IS NOT NULL')

  before_create :shorten_url


  def log_impression!
    self.update_attributes :impressions => self.impressions+1  
  end

  def short_url_path
    "http://localhost:3000/#{self.short_url}"
  end

  private

  def shorten_url
    self.short_url = ('a'..'z').to_a.shuffle[0,4].join if self.short_url.blank?
  end

end