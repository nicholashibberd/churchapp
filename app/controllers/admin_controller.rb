class AdminController < ApplicationController
  
  def update_parish_info
    @parish.update_attributes(params[:parish])
    redirect_to church_admin_path(@parish)
  end
  
  
end