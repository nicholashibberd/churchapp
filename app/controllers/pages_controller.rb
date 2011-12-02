class PagesController < ApplicationController
  include ChurchesHelper
  layout :choose_layout
  skip_before_filter :login_required, :only => ['show', 'advent_calendar']
  filter_access_to :edit, :attribute_check => true, :load_method => lambda { @institution.find_page(params[:id]) }
  
  def index
    @pages = @institution.pages
  end

  def show
    page_slug = on_institution_homepage?(request.path, @institution) ? 'welcome' : params[:id]
    @page = @institution.find_page(page_slug)
    return page_not_found unless @page
  end

  def new
    @page = @institution.pages.new
  end

  def edit
    @page = @institution.find_page(params[:id])
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
    @page = @institution.find_page(params[:id])
    if @page.update_attributes(params[:page])
      redirect_link = params[:page][:content_layout] ? edit_page_path(@institution, @page) : pages_path(@institution)
      redirect_to(redirect_link, :notice => 'Page was successfully updated.')
    else
      flash[:error] = "Page could not be updated"
      render :action => "edit"
    end
  end

  def destroy
    @page = @institution.find_page(params[:id])
    @page.destroy
    redirect_to(pages_path(@institution))
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
    if request[:action] == 'advent_calendar'
      'advent_calendar'
    else
      request[:action] == 'show' ? default_layout : 'admin'  
    end
    
  end
end
