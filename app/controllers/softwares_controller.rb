class SoftwaresController < ApplicationController

  def show

    @software = Software.find(:first, :conditions => {:title => params[:id]})

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @software }
    end
  end

  def new
    if session[:user_id] && pull_user_role(session[:user_id]) != 99
      @software = Software.new

      @categories = Category.find(:all, :order => "name")

      respond_to do |format|
        format.html # new.html.erb
      end
    else
      flash[:warning] = "Anonymous users cannot create new software entries.<br/>Please login or create a new user first."
      redirect_to :controller => 'auth', :action => 'login'
    end
  end

  def edit
    @software = Software.find(:first, :conditions => {:title => params[:id]})

    @categories = Category.find(:all, :order => "name")

    if session[:user_id] && pull_user_role(session[:user_id]) != 99
    
        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @software }
        end
    end

  end

  def update
    @software = Software.find(params[:id])

    respond_to do |format|
      if @software.update_attributes(params[:software])
	flash[:info] = 'Software was successfully updated.';
        format.html { redirect_to( :controller => 'softwares', :action => 'show', :id => @software.title) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @software.errors, :status => :unprocessable_entity }
      end
    end
  end


  def create
    if session[:user_id] && pull_user_role(session[:user_id]) != 99

      @software = Software.new(params[:software])
      @categories = Category.find(:all, :order => "name")

      # role 0  = Site Admin
      # role 1  = Privledged user
      # role 2  = Normal user
      # role 99 = Unverified user

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
      flash[:warning] = "Anonymous users cannot create new software entries.<br/>Please login or create a new user first."
      redirect_to :controller => 'auth', :action => 'login'
    end
  end


end
