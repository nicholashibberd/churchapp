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
end
