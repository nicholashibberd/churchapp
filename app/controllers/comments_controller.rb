class CommentsController < ApplicationController
  layout 'admin'
  
  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.find_comment(params[:id])
  end

  def create
    @article = Article.find(params[:article_id])
    @article.comments << Comment.new(params[:comment])
    page = Page.find(params[:page_id]) rescue nil
    path = page ? church_page_path(@institution, page) : single_article_path(@institution, @article)
    redirect_to path
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.find_comment(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to(edit_article_path(@institution, @article), :notice => 'Comment was successfully updated.')
    else
      render :action => "edit"
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to(comments_url)
  end
end
