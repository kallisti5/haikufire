class UsersController < ApplicationController

  def index
	redirect_to("/")
  end

  def login
    respond_to do |format|
      format.html # login.html.erb
    end
  end

  def authenticate
	require 'digest/md5'

	#User.new(params[:userform]) will create a new object of User, retrieve values from the form and store it variable @user.
	@user = User.new(params[:userform])

	if !@user.login or !@user.password
		flash[:notice] = "Please provide a login and a password"
		redirect_to :action => 'login'
	else
		# Lets not give away plaintext passwords... mmkay?
		pass_digest = Digest::MD5.hexdigest(@user.password)
		
		valid_user = User.find(:first,:conditions => ["login = ? and password = ?",@user.login, pass_digest])

		if valid_user
			#creates a session with username
			session[:user_id]=valid_user.login

			# update last login time
			valid_user.last_login = Time.now
			valid_user.save

			#redirects the user to our private page.
			redirect_to :action => 'profile', :id => @user.login
		else
			flash[:notice] = "Invalid User/Password"
			redirect_to :action=> 'login'
		end
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

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def success

  end


  def create

    @user = User.new(params[:user])

    @user.role = 2
    @user.created_at = Time.now

    respond_to do |format|
      if @user.save
	#format.html { redirect_to :action => 'profile', :id => @user.login }
	format.html { redirect_to :action => 'login' }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
  end

end
