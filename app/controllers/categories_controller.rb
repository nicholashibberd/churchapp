class CategoriesController < ApplicationController
  layout :choose_layout

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def category_articles
    @category = Category.find_by_slug(params[:category_id])
    @articles = @category.find_articles_by_church(@church, params[:month])
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        redirect_to(categories_path(@church), :notice => 'Category was successfully created.')
      else
        render :action => "new"
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to(categories_path(@church), :notice => 'Category was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to(categories_url)
  end
  
  def choose_layout
    ['index', 'category_articles'].include?(request[:action]) ? 'application' : 'admin'
  end
  
end
