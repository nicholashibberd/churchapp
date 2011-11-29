module NavHelper
  
  def nav_link(nav_item)
    link_target = nav_item.page ? church_page_path(@institution, nav_item.page) : nav_item.target
    if nav_item.page == @page
      link_to nav_item.name, link_target, :class => 'selected'
    else
      link_to nav_item.name, link_target
    end
  end
  
  def parish_nav_item(institution)
    unless institution == @institution
      link_to institution.name, church_home_path(institution)
    end
  end
  
  def admin_nav_item(institution)
    return nil unless access_to_institution?(institution)    
	  render 'admin/admin_dropdown', :institution => institution
  end

  def admin_left_nav
    unless request[:action] == 'institution_admin'
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
