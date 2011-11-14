class ArticlesController < ApplicationController
  layout :choose_layout
  
  def index

  end
  
  def edit
    @article = Article.find(params[:id])
    @category = @article.category
  end
  
  def new
    @category = Category.find_by_slug(params[:category_id])
    @article = @church.articles.new
  end
  
  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.new
  end
  
  def create
    @article = Article.new(params[:article])
    category = @article.category
    if @article.save
      redirect_to(category_path(@article.institution, category), :notice => "#{category.name.singularize} was successfully created")
    else
      flash[:error] = "There was an error creating the #{category.name.singularize}"
      render :action => "new"
    end
  end

  def update
    #institution = Institution.find(params[:article][:institution_id])
    @article = Article.find(params[:id])
    category = @article.category    
    if @article.update_attributes(params[:article])
      redirect_to(category_path(@article.institution, category), :notice => "#{category.name.singularize} was successfully updated.")
    else
      flash[:error] = "There was an error updating the #{category.name.singularize}"      
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    institution = @article.institution
    @article.destroy
    redirect_to(articles_path(institution))
  end
  
  def choose_layout
    ['show'].include?(request[:action]) ? 'application' : 'admin'
  end
  
end