module ChurchesHelper
  
  def display_for_parish_only(church, &block)
    if church.is_a?(Parish)
      content_tag(:div, &block)
    end
  end
  
  def on_church_homepage?(path, church)
    if church.is_a?(Parish)
      path == '/'
    else
      path == church_home_path(church)
    end
  end
end
