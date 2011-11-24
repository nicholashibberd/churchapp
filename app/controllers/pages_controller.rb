class PagesController < ApplicationController
  include ChurchesHelper
  layout :choose_layout
  skip_before_filter :login_required, :only => 'show'
  filter_access_to :edit, :attribute_check => true, :load_method => lambda { @church.find_page(params[:id]) }
  
  def index
    @pages = @church.pages
  end

  def show
    page_slug = on_church_homepage?(request.path, @church) ? 'welcome' : params[:id]
    @page = @church.find_page(page_slug)
    return page_not_found unless @page
  end

  def new
    @page = @church.pages.new
  end

  def edit
    @page = @church.find_page(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to(edit_page_path(@page.institution, @page), :notice => 'Page was successfully created.')
    else
      flash[:error] = "Page could not be created"
      render :action => "new"
    end
  end

  def update
    @page = @church.find_page(params[:id])
    if @page.update_attributes(params[:page])
      redirect_link = params[:page][:content_layout] ? edit_page_path(@church, @page) : pages_path(@church)
      redirect_to(redirect_link, :notice => 'Page was successfully updated.')
    else
      flash[:error] = "Page could not be updated"
      render :action => "edit"
    end
  end

  def destroy
    @page = @church.find_page(params[:id])
    @page.destroy
    redirect_to(pages_path(@church))
  end
  
  def order_widgets
    page = Page.find(params[:id])
    page.order_widgets(params)
    render :nothing => true
  end  
  
  def position_widgets
    widget = Widget.find(params[:id])
    widget.update_attributes(params)
    render :nothing => true    
  end
  
  def set_widget_area_height
    page = Page.find(params[:id])
    page.update_attributes(:widget_area_height => params[:height])
    render :nothing => true
  end
  
  def choose_layout
    request[:action] == 'show' ? 'application' : 'admin'  
  end
end
