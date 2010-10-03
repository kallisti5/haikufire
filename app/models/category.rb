class Category < ActiveRecord::Base
	has_many :softwares

	# friendly urls, makes url_for work
	def to_param
		name
	end
end
