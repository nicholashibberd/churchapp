class BackgroundImagesController < ApplicationController
  layout 'admin'
  
  def new
    @background_image = BackgroundImage.new
  end
  
  def edit
    
  end
  
  def index
    @background_images = @church.background_images.all
  end
  
  def create
    @background_image = BackgroundImage.new(params[:background_image])
    if @background_image.save
      redirect_to background_images_path(@background_image.institution), :notice => "Successfully created background_image."
    else
      flash[:error] = "There was an error creating the background_image"
      render :action => 'new'
    end
  end

  def edit
    @background_image = BackgroundImage.find(params[:id])
  end

  def update
    @background_image = BackgroundImage.find(params[:id])
    if @background_image.update_attributes(params[:background_image])
      redirect_to background_images_path(@church), :notice  => "Successfully updated background_image."
    else
      flash[:error] = "There was an error updating the background_image"
      render :action => 'edit'
    end
  end
  
  def destroy
    @background_image = BackgroundImage.find(params[:id])
    @background_image.destroy

    redirect_to(background_images_path(@church))
  end
  
  
end