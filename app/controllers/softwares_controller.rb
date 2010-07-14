class SoftwaresController < ApplicationController

  def show

    @software = Software.find(:first, :conditions => {:title => params[:id]})

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @software }
    end
  end

  def new
    @software= Software.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create

      @software = Software.new(params[:software])

      # role 0  = Site Admin
      # role 1  = Privledged user
      # role 2  = Normal user
      # role 99 = Unverified user

      @software.compiled = "Unknown"

      @software.created = Time.now
      @software.updated = Time.now

      respond_to do |format|
        if @software.save
          flash[:info] = "Successfully created new entry."
          format.html { redirect_to :action => 'softwares', :id => @software.title }
          format.xml  { render :xml => @software, :status => :created, :location => @software }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @sofware.errors, :status => :unprocessable_entity }
        end
      end

  end


end
