class Url < ActiveRecord::Base
  attr_accessible :orig_url, :short_url, :impressions

end
