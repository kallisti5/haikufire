class User < ActiveRecord::Base

	validates_presence_of :login, :name
	validates_uniqueness_of :login

	def password=(password)
		require 'digest/md5'
		write_attribute :password, Digest::MD5.hexdigest( password )
	end
end
