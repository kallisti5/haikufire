class Software < ActiveRecord::Base

	belongs_to :category	# many softwares belong to a single category
	belongs_to :user	# many softwares belong to a single user (submitter)

	has_many :downloads	# many downloads belong to a single piece of software

	validates_presence_of :title
	validates_format_of     :title,
				:with       => /^[a-z0-9\s\']+$/i,
				:message    => 'must only contain valid characters ( eg. a-z 0-9 \' )'

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

	validates_attachment_size :icon, :less_than=>1.megabyte, :if => Proc.new { |imports| !imports.icon_file_name.blank? }
	validates_attachment_content_type	:icon, :content_type => ['image/jpeg', 'image/png']

	# paperclip application screenshot
	has_attached_file :screenshot,
		:default_url => "/assets/no_screenshot.png",
		:url => "/assets/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/:id/:style/:basename.:extension",
		:convert_options => {
			:shot_sm => "-crop '400x128< +1+1' -strip"}, 
		:styles => {
                        :shot_sm => "600x128<"}

	validates_attachment_content_type	:screenshot, :content_type => ['image/jpeg', 'image/png']
	### End paperclip magic

	# friendly urls, makes url_for work
	def to_param
		title
	end
end
