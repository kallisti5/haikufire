class Download < ActiveRecord::Base
  belongs_to :software    # one software item has many downloads
  has_one :arch						# one download has on arch

  has_attached_file :dl,
                    :default_url => "/error/dlnotexist",
                    :url => "/assets/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/:id/:style/:basename.:extension"

end
