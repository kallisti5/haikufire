class SoftwareController < ApplicationController
  # GET /categories/1
  # GET /categories/1.xml
  def show

    @software = Software.find(:all, :conditions => {:title => params[:id]})

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @software }
    end
  end

end
