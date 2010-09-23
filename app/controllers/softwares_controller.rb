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
       ( User.where(:id => session[:user_id]).first.role == 0 || @software.user.first.id == session[:user_id] )
				respond_with(@software)
    else
      flash[:warning] = "You cannot edit software you have not created. Please login or create a new user first."
			redirect_to [:login, @auth]
    end
  end

  def update
    @software = Software.find(params[:id])

    if session[:user_id] &&
       ( User.where(:id => session[:user_id]).first.role == 0 || @software.user.first.id == session[:user_id] )

				respond_to do |format|
          if @software.update_attributes(params[:software])
            flash[:info] = 'Software was successfully updated.';
	          format.html { redirect_to :action => 'show', :id => @software.title }
	          format.xml  { render :xml => @software, :status => :created, :location => @software }
          else
						format.html { render :action => "edit" }
						format.xml  { render :xml => @sofware.errors, :status => :unprocessable_entity }
          end
				end
    else
      flash[:warning] = "You cannot edit software you have not created. Please login or create a new user first."
			redirect_to [:login, @auth]
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
