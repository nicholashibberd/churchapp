class ChurchesController < ApplicationController
  layout 'application'
  
  def index
    @churches = Church.all
  end

  def show
    @church = Church.find(params[:id])
  end

  def new
    @church = Church.new
  end

  def edit
    @church = Church.find(params[:id])
  end

  def create
    @church = Church.new(params[:church])
    if @church.save
      redirect_to(@church, :notice => 'Church was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @church = Church.find(params[:id])
    if @church.update_attributes(params[:church])
      redirect_to(@church, :notice => 'Church was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @church = Church.find(params[:id])
    @church.destroy
    redirect_to(churches_url)
  end
end
