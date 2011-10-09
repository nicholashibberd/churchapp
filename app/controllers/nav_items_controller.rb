class NavItemsController < ApplicationController
  layout 'admin'
  def index
    @nav_items = NavItem.all
  end

  def show
    @nav_item = NavItem.find(params[:id])
  end

  def new
    @nav_menu = NavMenu.find(params[:nav_menu_id])
    @nav_item = @nav_menu.nav_items.new
  end

  def edit
    @nav_menu = NavMenu.find(params[:nav_menu_id])
    @nav_item = NavItem.find(params[:id])
  end

  def create
    @nav_item = NavItem.new(params[:nav_item])
    if @nav_item.save
      redirect_to edit_nav_menu_path(@church, @nav_item.nav_menu)
    else
      render :action => "new"
    end
  end

  def update
    @nav_item = NavItem.find(params[:id])

    if @nav_item.update_attributes(params[:nav_item])
      redirect_to edit_nav_menu_path(@church, @nav_item.nav_menu)
    else
      render :action => "edit"
    end
  end

  def destroy
    @nav_item = NavItem.find(params[:id])
    nav_menu = @nav_item.nav_menu
    @nav_item.destroy

    redirect_to(nav_menu_nav_items_path(@church, nav_menu))
  end
end
