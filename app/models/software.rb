class Software < ActiveRecord::Base

	validates_presence_of :title
	validates_presence_of :category_id
	validates_presence_of :author
	validates_presence_of :description
	validates_presence_of :compiled

	validates_uniqueness_of :title

	### Start paperclip magic
	# in the future Amazon s3 image storage is possible
		# :storage => :s3,
		# :bucket => "bucket name",
		# :s3_credentials => {
		#	:access_key_id => "access key id",
		#	:secret_access_key => "secret access key"
		# },

	# paperclip application icon
	has_attached_file :icon,
		:default_url => "/assets/no_icon.png",
		:url => "/assets/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/:id/:style/:basename.:extension",
		:styles => {
			:icon => "32x32#"}

	# paperclip application screenshot
	has_attached_file :screenshot,
		:default_url => "/assets/no_screenshot.png",
		:url => "/assets/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/:id/:style/:basename.:extension",
		:styles => {
                        :shot_sm => "128x128#"}

	### End paperclip magic

end
