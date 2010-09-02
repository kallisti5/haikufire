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
		valid_user = User.where(:login => @user.login, :password => @user.password) 

		if valid_user.exists? and valid_user.role != 99
			#creates a session with username
			session[:user_login]=valid_user.login
			session[:user_id]=valid_user.id

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

	@user = User.where(:conditions => { :login => params[:id] }, :limit => 1)
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

      # role 0  = Site Admin
      # role 1  = Privledged user
      # role 2  = Normal user
      # role 99 = Unverified user

      @user.role = 99
      @user.created_at = Time.now

      @user.validation_hash = randomhash(64)

      respond_to do |format|
        if @user.save_with_captcha
          #format.html { redirect_to :action => 'profile', :id => @user.login }
          MailWorker::deliver_verification(@user.email, @user.validation_hash)
          flash[:info] = "User creation successful. An email has been sent to #{@user.email}.<br/>Please click the validation link in the sent email before logging in."
          format.html { redirect_to :action => 'login' }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end

  end

  # url to confirm email validation
  def validate
      validation_hash = params[:id]

      # ensure hash looks proper
      if validation_hash.length == 64
         user = User.where(:conditions => ["role = 99 and validation_hash = ?", validation_hash ], :limit => 1)
      else
         user = nil
      end

      if user
         user.role = 2
         user.validation_hash = ""
         user.save
         flash[:info] = "User validation successful, thanks for registering #{user.login}!<br/>You may now login."
      else
         flash[:warning] = "User validation was un-successful, invalid validation token passed."
      end

      respond_to do |format|
        format.html { redirect_to :action => 'login' }
      end

  end

  def update
  end

end
