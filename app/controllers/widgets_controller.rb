class WidgetsController < ApplicationController
  layout 'admin'

  def index
    @widgets = Widget.all
  end

  def show
    @widget = Widget.find(params[:id])
  end

  def new
    @page = @church.find_page(params[:page_id])
    @widget_class = params[:widget_type].classify.constantize
    @widget = @widget_class.new
    3.times { @widget.map_markers.build } if @widget.is_a?(MapWidget)
    render :layout => false if params[:lightbox]    
  end

  def edit
    @page = @church.find_page(params[:page_id])
    @widget = @page.find_widget(params[:id])
    render :layout => false if params[:lightbox]
  end

  def create
    @page = @church.find_page(params[:page_id])
    @page.add_widget(params)
    redirect_to edit_page_path(@church, @page)
  end

  def update
    @page = @church.find_page(params[:page_id])
    @widget = @page.find_widget(params[:id])
    @page.update_widget(params)
    redirect_to edit_page_path(@church, @page)
  end

  def destroy
    @widget = Widget.find(params[:id])
    page = @widget.page
    @widget.destroy
    redirect_to edit_page_path(@church, page)
  end
  
  def download_pdf 
    return send_file Rails.root.join("public", "pdf", "sanderstead", "making_space27jan11.pdf"), :type => "application/pdf", :filename => "making_space.pdf", :disposition => 'inline'
  end
  
end
