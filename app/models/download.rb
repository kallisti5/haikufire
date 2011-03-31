class Download < ActiveRecord::Base
  belongs_to	:software			# one software item has many downloads
  belongs_to	:arch					# one download has one arch

	#joins(:arch).where(:arch => x)

	def self.for_arch(name) 
		where("downloads.arch_id = ?", Arch.where(:name => name).first.id)
	end 

  has_attached_file :dl,
                    :default_url => "/error/dlnotexist",
                    :url => "/assets/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/:id/:style/:basename.:extension"

end
