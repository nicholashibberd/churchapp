class PagesController < ApplicationController
  layout :choose_layout
  skip_before_filter :login_required, :only => 'show'
  
  def index
    @pages = @church.pages
  end

  def show
    page_slug = params[:id] ||= 'welcome'
    @page = @church.find_page(page_slug)
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
      redirect_to(pages_path(@church), :notice => 'Page was successfully updated.')
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
  
  def choose_layout
    request[:action] == 'show' ? 'application' : 'admin'  
  end
end
