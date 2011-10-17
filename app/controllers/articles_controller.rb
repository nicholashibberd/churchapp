class ArticlesController < ApplicationController
  layout :choose_layout
  
  def index

  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def new
    @article = @church.articles.new
  end
  
  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.new
  end
  
  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to(articles_path(@article.institution), :notice => 'Article was successfully created.')
    else
      flash[:error] = 'There was an error creating the article'
      render :action => "new"
    end
  end

  def update
    institution = Institution.find(params[:article][:institution_id])
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to(articles_path(institution), :notice => 'Article was successfully updated.')
    else
      flash[:error] = 'There was an error updating the article'      
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