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

  def get
  end
end
