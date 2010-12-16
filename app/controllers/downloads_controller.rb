class DownloadsController < ApplicationController
  def show
    @software = Software.where( :title => params[:id] ).first
    @arches = Arch.where( :active => 1 )
  end

  def update
  end

  def delete
  end

  def destroy
  end

	# called via /dl/ route
  def get
		# grab our software object
		@software = Software.where( :title => params[:id] ).first
		if !@software
			flash[:warning] = "Invalid software item. (error code: 0xNOENTRY.GET)"
			redirect_to(:controller => 'categories')
		else
			@download = @software.downloads.arch.where( :name => params[:arch] ).first
			#@download = @software.downloads.arch.where( :arch => params[:arch] )
			#@download = @software.downloads.first.methods
			if !@download
				flash[:warning] = "Invalid architecture for software item. (error code: 0xNOARCH.GET)"
				redirect_to(@software)
			end
		end
  end
end
