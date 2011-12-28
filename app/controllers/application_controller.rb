class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup_site, :login_required

  include ApplicationHelper
  include UsersHelper
  
  def setup_site
    @site = Site.where(:domain => request.domain(2)).first
    @site ||= Site.first

    @institution = @site.find_institution(params[:institution_id])
    @root = @site.root
  end
  
  def church
    
  end
  
  def login_required
    if signed_in?
      return true
    end
    
    flash[:error]='Please login to continue'
    redirect_to signin_path
    return false
  end
  
  def page_not_found
    render :template => 'errors/page_not_found', :status => 404, :layout => default_layout
  end
    
end