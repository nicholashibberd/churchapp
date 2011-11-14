class CategoriesController < ApplicationController
  skip_before_filter :login_required
  layout :choose_layout
  
  def category_articles
    @category = Category.find_by_slug(params[:category_id])
    @articles = @category.find_articles_by_church(@church, params[:month])
  end
  
  def show
    @category = Category.find_by_slug(params[:id])
    @articles = @category.find_articles_by_church(@church, nil)
  end
  
  def choose_layout
    request[:action] == 'category_articles' ? 'application' : 'admin'  
  end

end
