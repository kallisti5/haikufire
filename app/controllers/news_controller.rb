class NewsController < ApplicationController
  # GET /news
  # GET /news.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
