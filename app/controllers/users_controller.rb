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
		require 'digest/sha2'

		@user = User.new(params[:userform])
	
		if !@user.username or !@user.password
			flash[:warning] = "Please provide a username and a password"
			redirect_to [:login]
		else
			cannidate = User.where( :username => @user.username ).first 

			if cannidate and cannidate.pass_hash == Digest::SHA2.hexdigest(cannidate.pass_salt + @user.password)
				valid_user = cannidate
			end
	
			if valid_user and valid_user.role != 99
				#creates a session with username
				session[:user_login]=valid_user.username
				session[:user_id]=valid_user.id
	
				# update last login time
				valid_user.last_login = Time.now
				valid_user.save
	
				#redirects the user to our private page.
				redirect_to :action => 'profile', :id => @user.username
			else
				flash[:warning] = "Invalid Username/Password"
				redirect_to [:login]
			end
		end
  end

  def logout
	if session[:user_id]
		reset_session
		redirect_to [:login]
	end
  end

  def profile
		require 'digest/md5'

		@user = User.where( :username => params[:id] ).first

		if @user
			# convert email into md5 hash for gravatar
			@email_hash = Digest::MD5.hexdigest(@user.email.downcase)
		else
			flash[:warning] = "User does not exist!"
			redirect_to "/"
		end
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
          MailWorker::deliver_verification(@user.email, @user.validation_hash)
          flash[:info] = "User creation successful. An email has been sent to #{@user.email}. Please click the validation link in the sent email before logging in."
          format.html { redirect_to [:login] }
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
         user = User.where(:role => 99, :validation_hash => validation_hash ).first
      else
         user = nil
      end

		if user
			user.attributes = { :role => 2, :validation_hash => "" }
			user.save(:validate => false)

			flash[:info] = "User validation successful, thanks for registering #{user.username}! You may now login."
		else
			flash[:warning] = "User validation was un-successful, invalid validation token passed."
		end

		respond_to do |format|
        format.html { redirect_to [:login] }
		end

  end

  def edit
    @user = User.where(:username => params[:id]).first
		if @user.id != session[:user_id]
			flash[:warning] = "You do not have the proper access to edit this user!";
			respond_to do |format|
      	  format.html { redirect_to [:login] }
			end
		else
    	respond_to do |format|
    	  format.html
    	  format.xml  { render :xml => @user }
    	end
		end
	end

  def update
		@user = User.find(params[:id])

		# I think forgery protection takes care of this... but just incase.
		if @user.id == session[:user_id] and @user.update_attributes(params[:user])

			flash[:info] = "User update successful."

			respond_to do |format|
				format.html { redirect_to :action => "profile", :id => @user.username }
			end
		else
			respond_to do |format|
       	format.html { render :action => "edit" }
       	format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
  end

end
