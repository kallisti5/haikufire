class User < ActiveRecord::Base

	has_many :softwares

	validates_length_of	:username, :within => 3..32, :message => 'must be between 3 and 32 characters'
	validates_uniqueness_of :username

	validates_length_of	:password, :within => 5..64, :message => 'must be between 5 and 64 characters'

	validates_presence_of :name

	validates_uniqueness_of :email
	validates_format_of     :email,
				:with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
				:message    => 'must be valid'

	apply_simple_captcha

	def password=(password)
		unless password.blank?
			require 'digest/md5'
			write_attribute :password, Digest::MD5.hexdigest( password )
		end
	end

end
