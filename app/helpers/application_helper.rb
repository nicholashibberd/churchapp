module ApplicationHelper
  
  def logo
    if @church.is_a?(Church)
      link_to image_tag("sanderstead/#{@church.slug}-logo.png"), church_home_path(@church)
    else
      link_to image_tag("sanderstead/parish-logo.png"), parish_home_path
    end
  end
  
  def sub_logo
    if @church.is_a?(Church)
      link_to image_tag("sanderstead/parish-logo-small.png"), parish_home_path
    end
  end
  
  def form_path(instance, church)
    action =  instance.new_record? ? 'create' : 'update'
    {:url => {:controller => instance.class.to_s.tableize, :action => action, :church_id => church.slug}}
  end
  
  def page_id
    request.path.gsub('/', '-').underscore[1..-1]
  end
  
end
