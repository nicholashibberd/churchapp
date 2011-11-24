module NavHelper
  
  def nav_link(nav_item)
    link_target = nav_item.page ? church_page_path(@church, nav_item.page) : nav_item.target
    if nav_item.page == @page
      link_to nav_item.name, link_target, :class => 'selected'
    else
      link_to nav_item.name, link_target
    end
  end
  
  def parish_nav_item(church)
    unless church == @church
      link_to church.name, church_home_path(church)
    end
  end
  
  def admin_nav_item(church)
    return nil unless access_to_institution?(church)    
	  render 'admin/admin_dropdown', :church => church
  end

  def admin_left_nav
    unless request[:action] == 'church_admin'
      render 'admin/left_nav' if current_user
    end
  end
  
  def admin_left_nav_item(link, target, action, controller)
    return nil unless display_link?(action, controller)
    if request[:controller] == controller.to_s
      content_tag(:div, (link_to link, target, :class => 'selected', :id => controller.to_s), :class => 'left_nav_item selected')
    else
      content_tag(:div, (link_to link, target, :id => controller.to_s), :class => 'left_nav_item')
    end
  end
end
