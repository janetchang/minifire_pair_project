class Url < ActiveRecord::Base
  attr_accessible :orig_url, :short_url, :impressions

  validates :orig_url, :format => { :with => /htt(p|ps):\/\/.+[.]/, :message => "URL must include 'http://' or 'https://'" }

end
