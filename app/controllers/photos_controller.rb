class PhotosController < ApplicationController
  layout 'admin', :except => :show
  
  def index
    @photos = @church.photos.all
  end

  def new
    @photo = @church.photos.new
  end
  
  def show
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to photos_path(@photo.church), :notice => "Successfully created photo."
    else
      raise @photo.errors.inspect
      render :action => 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      redirect_to photos_path(@church), :notice  => "Successfully updated photo."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    redirect_to(photos_path(@church))
  end
  
  def order_photos
    church = Church.find(params[:id])
    church.order_photos(params)
    render :nothing => true
  end  
  

end
