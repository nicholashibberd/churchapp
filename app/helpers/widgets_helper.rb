module WidgetsHelper
  def render_widget(page, action, widget)
    render :partial => "widgets/#{action}/#{widget.widget_type}", :locals => {:page => page, :widget => widget}
  end
  
  def path_for_widget(page, widget)
    widget.new_record? ? page_widgets_path(@institution, page) : page_widget_path(@institution, page, widget)
  end

  def path_for_comment(article, comment)
    comment.new_record? ? article_comments_path(@institution, article) : article_comment_path(@institution, article, comment)
  end

  def path_for_nav_item(nav_menu, nav_item)
    nav_item.new_record? ? nav_menu_nav_items_path(@institution, nav_menu) : nav_menu_nav_item_path(@institution, nav_menu, nav_item)
  end
  
  def gallery_item_class(widget, index)
    if widget.display == 'Stacked'
      (index + 1) % 4 == 0 ? 'gallery_item' : 'gallery_item gallery_item_float'
    end
  end
end
