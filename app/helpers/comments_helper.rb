module CommentsHelper
  
  def display_article_comments(article, &block)
    if request[:controller] == 'pages'
      content_tag(:div, :class => 'article_comments_bar', &block)
    else
      render 'comments/comments', :article => article if article.comments.any?
    end
  end
end
