class CategoriesController < ApplicationController
  skip_before_filter :login_required
  
  def category_articles
    @category = Category.find_by_slug(params[:category_id])
    @articles = @category.find_articles_by_church(@church, params[:month])
  end

end
