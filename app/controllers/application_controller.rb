class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup_site, :login_required
  include UsersHelper
  
  def setup_site
    @site = Site.where(:domain => request.domain(2)).first    
    @site ||= Site.first
    
    @church = @site.find_institution(params[:institution_id])
    @parish = @church.is_a?(Parish) ? @church : @church.parish
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
  
end