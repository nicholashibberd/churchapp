class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup_site, :display_admin_header
  
  def setup_site
    @site = Site.where(:domain => request.domain(2)).first
    
    if @site.site_type == 'parish'
      @parish = @site.parish       
      @church = @parish.find_church(params[:church_id])
      @church ||=  @parish
    else
      @church = @site.church
    end
  end
  
  def display_admin_header
    @admin = true
  end
  
end
