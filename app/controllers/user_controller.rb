class UserController < ApplicationController
  def login
  end

  def authenticate
	require 'digest/md5'

	#User.new(params[:userform]) will create a new object of User, retrieve values from the form and store it variable @user.
	@user = User.new(params[:userform])

	# Lets not give away plaintext passwords... mmkay?
	pass_digest = Digest::MD5.hexdigest(@user.password)
	
	valid_user = User.find(:first,:conditions => ["login = ? and password = ?",@user.login, pass_digest])

	if valid_user
		#creates a session with username
		session[:user_id]=valid_user.login
		#redirects the user to our private page.
		redirect_to :action => 'profile', :id => @user.login
	else
		flash[:notice] = "Invalid User/Password"
		redirect_to :action=> 'login'
	end
  end

  def logout
	if session[:user_id]
		reset_session
		redirect_to :action=> 'login'
	end
  end

  def profile
	require 'digest/md5'

	@user = User.find(:first, :conditions => { :login => params[:id] } )
	@email_hash = Digest::MD5.hexdigest(@user.email.downcase)
  end

  def update
  end

end
