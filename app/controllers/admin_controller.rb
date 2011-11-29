class AdminController < ApplicationController
  
  def update_parish_info
    @root.update_attributes(params[:parish])
    redirect_to church_admin_path(@root)
  end
  
  
end