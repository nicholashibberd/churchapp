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
      redirect_to(articles_path(@article.church), :notice => 'Article was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    church = Church.find(params[:article][:church_id])
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to(articles_path(church), :notice => 'Article was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to(articles_path(@church))
  end
  
  def choose_layout
    ['show'].include?(request[:action]) ? 'application' : 'admin'
  end
  
end