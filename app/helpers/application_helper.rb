module ApplicationHelper
  
  def logo
    if @institution.is_a?(Church)
      link_to image_tag("sanderstead/#{@institution.slug}-logo.png"), church_home_path(@institution)
    else
      link_to image_tag("sanderstead/parish-logo.png"), parish_home_path
    end
  end
  
  def sub_logo
    if @institution.is_a?(Church)
      link_to image_tag("sanderstead/parish-logo-small.png"), parish_home_path
    end
  end
  
  def form_path(instance, church)
    action = instance.new_record? ? 'create' : 'update'
    {:url => {:controller => instance.class.to_s.tableize, :action => action, :institution_id => church.slug}}
  end
  
  def page_id
    request.path.gsub('/', '-').underscore[1..-1]
  end
  
  def display_permitted_to_link(action, controller, link_text, link)
    if permitted_to? action, controller
	  	link_to link_text, link
	  else
	    link_text
		end
  end
  
  def display_link?(action, controller)
    access_to_institution? and (permitted_to? action, controller)
  end
  
  def access_to_institution?(church = @institution)
    current_user.institution.type == Parish || church == current_user.institution ? true : false
  end
  
  def default_layout
    !@site.theme.nil? ? @site.theme : 'application'
  end
    
end
