class NavMenusController < ApplicationController
  layout 'admin'

  def index
    @nav_menus = NavMenu.all
  end

  def show
    @nav_menu = NavMenu.find(params[:id])
  end

  def new
    @nav_menu = @church.nav_menus.new
  end

  def edit
    @nav_menu = NavMenu.find(params[:id])
  end

  def create
    @nav_menu = NavMenu.new(params[:nav_menu])
    
    if @nav_menu.save
      redirect_to(nav_menus_path(@church), :notice => 'Nav menu was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @nav_menu = NavMenu.find(params[:id])

    if @nav_menu.update_attributes(params[:nav_menu])
      redirect_to(nav_menus_path(@church), :notice => 'Nav menu was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @nav_menu = NavMenu.find(params[:id])
    @nav_menu.destroy

    redirect_to(nav_menus_url(@church))
  end
  
  def order_nav_items
    nav_menu = NavMenu.find(params[:id])
    nav_menu.order_nav_items(params)
    render :nothing => true
  end  
  
end