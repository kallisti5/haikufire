class CategoryController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show

    @category = Category.where(:name => params[:id], :limit => 1)
    @softwares = Software.where(:category_id => @category.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

end
