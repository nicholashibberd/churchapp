class AdminController < ApplicationController
  
  def update_site_info
    @site.update_attributes(params[:site])
    redirect_to church_admin_path(@root)
  end
  
  
end