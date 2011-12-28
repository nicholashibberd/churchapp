module ChurchesHelper
  
  def display_for_root_only(institution, &block)
    if institution.is_root?
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
