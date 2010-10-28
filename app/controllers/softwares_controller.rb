class SoftwaresController < ApplicationController
	respond_to :html, :xml

	def index
		redirect_to :categories
	end

	def show
		@software = Software.where( :title => params[:id] ).first

		respond_with(@software)
	end

	def new
		if session[:user_id] && User.find(session[:user_id]).role != 99

			@software = Software.new
			@categories = Category.order('name ASC')

			respond_with(@software)
		else
		flash[:warning] = "Anonymous users cannot create new software entries. Please login or create a new user first."
			redirect_to [:login, @auth]
		end
	end

	def edit
		@software = Software.where( :title => params[:id] ).first
		@categories = Category.order('name ASC')

		if session[:user_id] &&
		( User.where(:id => session[:user_id]).first.isadmin? || @software.user.id == session[:user_id] )
			respond_with(@software)
		else
			flash[:warning] = "You cannot edit software you have not created. (error code: 0xNICETRY.EDT)"
			redirect_to(@software)
		end
	end

	def update
		@software = Software.where(:title => params[:id]).first
		redirect_to('/') and return if !@software		# safty catch for people doing things they shouldn't

		if session[:user_id] &&
		( User.where(:id => session[:user_id]).first.isadmin? || @software.user.id == session[:user_id] )

			respond_to do |format|
				if @software.update_attributes(params[:software])
					flash[:info] = 'Software was successfully updated.';
					format.html { redirect_to :action => 'show', :id => @software.title }
					format.xml  { render :xml => @software, :status => :created, :location => @software }
				else
					# We have to repull categories to show the edit page again
					@categories = Category.order('name ASC')
					format.html { render :action => "edit" }
					format.xml  { render :xml => @sofware.errors, :status => :unprocessable_entity }
				end
			end
		else
		flash[:warning] = "You cannot edit software you have not created. (error code: 0xNICETRY.UPD)"
			redirect_to(@software)
		end
	end

	def delete
		@software = Software.where(:title => params[:id]).first
		redirect_to('/') and return if !@software		# safty catch for people doing things they shouldn't

		if session[:user_id] &&
		( User.where(:id => session[:user_id]).first.isadmin? || @software.user.id == session[:user_id] )
			respond_to do |format|
				format.html # delete.html.erb
			end
		else
			flash[:warning] = "You cannot delete software you have not created. (error code: 0xNICETRY.DEL)"
			redirect_to(@software)
		end
	end

	def destroy
		@software = Software.where(:title => params[:id]).first
		redirect_to('/') and return if !@software		# safty catch for people doing things they shouldn't
		redirect_to(@software) and return if params[:cancel]

		if session[:user_id] &&
		( User.where(:id => session[:user_id]).first.isadmin? || @software.user.id == session[:user_id] )
			@software.destroy
			respond_to do |format|
				format.html { redirect_to softwares_path }
			end
		else
		flash[:warning] = "You cannot delete software you have not created. (error code: 0xNICETRY.DES)"
			redirect_to(@software)
		end
	end

	def create
		if session[:user_id] && pull_user_role(session[:user_id]) != 99
			@software = Software.new(params[:software])
			@categories = Category.order('name ASC')
			
			# role 0  = Site Admin
			# role 1  = Privledged user
			# role 2  = Normal user
			# role 99 = Unverified user
			
			@software.user_id = session[:user_id]
			@software.created = Time.now
			@software.updated = Time.now
			
			respond_to do |format|
				if @software.save
					flash[:info] = "Successfully created new entry."
					format.html { redirect_to :action => 'show', :id => @software.title }
					format.xml  { render :xml => @software, :status => :created, :location => @software }
				else
					format.html { render :action => "new" }
					format.xml  { render :xml => @sofware.errors, :status => :unprocessable_entity }
				end
			end
		else
			flash[:warning] = "Anonymous users cannot create new software entries. Please login or create a new user first."
			redirect_to [:login, @auth]
		end
	end
end
