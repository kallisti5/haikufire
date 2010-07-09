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

	@user = User.new(params[:userform])

	if !@user.login or !@user.password
		flash[:warning] = "Please provide a login and a password"
		redirect_to :action => 'login'
	else
		# @user.password is converted to an md5 hash in the model code
		valid_user = User.find(:first,:conditions => ["login = ? and password = ?",@user.login, @user.password]) 

		if valid_user
			#creates a session with username
			session[:user_id]=valid_user.login

			# update last login time
			valid_user.last_login = Time.now
			valid_user.save

			#redirects the user to our private page.
			redirect_to :action => 'profile', :id => @user.login
		else
			flash[:warning] = "Invalid User/Password"
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
	# convert email into md5 hash for gravatar
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
        if @user.save_with_captcha
          #format.html { redirect_to :action => 'profile', :id => @user.login }
          MailWorker::deliver_verification(@user.email)
          flash[:info] = "User creation successful, please validate your email before logging in."
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
