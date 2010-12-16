class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all(:order => 'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show

    @category = Category.where(:name => params[:id]).first
    @softwares = @category.softwares.paginate(:per_page => 12, :page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

end
