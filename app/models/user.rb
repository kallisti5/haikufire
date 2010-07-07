class User < ActiveRecord::Base

	validates_presence_of :name
	validates_uniqueness_of :email
	validates_format_of     :email,
				:with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
				:message    => 'must be valid'

	validates_presence_of :login
	validates_uniqueness_of :login


	validates_presence_of :password, :message => 'must be greater then 4 characters'


	def password=(password)
		if password.length > 4
		require 'digest/md5'
		write_attribute :password, Digest::MD5.hexdigest( password )
		end
	end

end
