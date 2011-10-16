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
    if church == @church || church == @parish
      link_to church.name, church_admin_path(church), :class => 'selected'
    else
      link_to church.name, church_admin_path(church)
    end
  end

  def admin_parish_nav_item
    if @parish == @church
      link_to 'Parish', church_admin_path, :class => "selected"
    else
      link_to 'Parish', church_admin_path
    end
  end
end
