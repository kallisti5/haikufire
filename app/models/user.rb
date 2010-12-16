require 'digest/sha2'

class User < ActiveRecord::Base

	# Temporary in memory storage for virtual plaintext password and confrimation password
	attr_accessor :password, :password_confirmation

	has_many :softwares

	validates_length_of	:username, :within => 3..32, :message => 'must be between 3 and 32 characters'

	validates_format_of     :username,
		:with       => /^[a-z0-9]+$/i,
		:message    => 'must only contain valid characters ( eg. a-z 0-9 )'

	validates_uniqueness_of :username

	validates_confirmation_of :password, :if=>:password_changed?
	validates_length_of	:password, :within => 5..64, :message => 'must be between 5 and 64 characters'

	validates_presence_of :name

	validates_uniqueness_of :email
	validates_format_of     :email,
		:with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
		:message    => 'must be valid'

	apply_simple_captcha

	before_save :hash_password, :if=>:password_changed?

	def isadmin?
		if self.role == 0
			true
		else
			false
		end
	end	

private
	def password_changed?
		!@password.blank?
	end

	def hash_password
		# Generate a new salt for this password hash
		self.pass_salt = ActiveSupport::SecureRandom.base64(16)
		# Convert salted password into a hash, store it as well
		self.pass_hash = Digest::SHA2.hexdigest(self.pass_salt + @password)
	end

end
