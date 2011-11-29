module ChurchesHelper
  
  def display_for_parish_only(church, &block)
    if church.is_a?(Parish)
      content_tag(:div, &block)
    end
  end
  
  def on_institution_homepage?(path, institution)
    if institution.is_root?
      path == '/'
    else
      path == church_home_path(church)
    end
  end
end
