class Software < ActiveRecord::Base
	#belongs_to :category

	validates_presence_of :title
	validates_presence_of :category_id
	validates_presence_of :author
	validates_presence_of :description
	validates_presence_of :compiled

	validates_uniqueness_of :title

	# paperclip magic
	# in the future Amazon s3 image storage is possible
	has_attached_file :icon,
		:default_url => "/assets/no_icon.png",
		:url => "/assets/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/:id/:style/:basename.:extension",
		:styles => {
			:icon => "32x32#"}

	has_attached_file :screenshot,
		:default_url => "/assets/no_screenshot.png",
		:url => "/assets/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/:id/:style/:basename.:extension",
		:styles => {
                        :shot_sm => "128x128#"}

end
