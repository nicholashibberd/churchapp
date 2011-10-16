require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe NavItemsController do
  
  before(:each) do
    setup_site
    @request.host = 'www.example.com'
    @nav_menu = Factory(:nav_menu, :church_id => @church.id)
    @page = Factory(:page)
    @nav_item1 = Factory(:nav_item, :nav_menu_id => @nav_menu.id, :page_id => @page.id)
    @nav_item2 = Factory(:nav_item, :nav_menu_id => @nav_menu.id, :target => "http://www.google.com")
    controller.stub!(:signed_in?).and_return true
  end
  
  it "should allow access to the new action" do
    NavMenu.should_receive(:find).and_return @nav_menu
    get 'new', :nav_menu_id => @nav_menu.id, :church_id => @church.slug
    response.should be_success
  end

  it "should allow access to the edit action" do
    NavMenu.should_receive(:find).and_return @nav_menu
    NavItem.should_receive(:find).and_return @nav_item1
    get 'edit', :nav_menu_id => @nav_menu.id, :church_id => @church.slug, :id => @nav_item1.id
    response.should be_success
  end
  
  it "should create nav_item and redirect when valid" do
    lambda do
      post 'create', :nav_item => Factory.attributes_for(:nav_item).merge(:nav_menu_id => @nav_menu.id)
      response.should be_redirect
      response.location.should include edit_nav_menu_path(@church, @nav_item1.nav_menu)
    end.should change(NavItem, :count).by(1)
  end

  it "should display flash message and render new action when invalid" do
    lambda do
      NavItem.should_receive(:new).and_return @nav_item1
      @nav_item1.should_receive(:save).and_return false
      post 'create', :nav_item => Factory.attributes_for(:nav_item).merge(:nav_menu_id => @nav_menu.id)
      flash[:error].should == "Nav Item could not be created"
      response.should render_template "new"
    end.should_not change(NavItem, :count)
  end

  it "should update nav_item and redirect when valid" do
    NavItem.should_receive(:find).and_return @nav_item1
    @nav_item1.should_receive(:update_attributes).and_return true
    post 'update', :church_id => @church.slug, :id => @nav_item1.id
    response.should be_redirect
    response.location.should include edit_nav_menu_path(@church, @nav_item1.nav_menu)
  end

  it "should display flash message and render edit action when invalid" do
    NavItem.should_receive(:find).and_return @nav_item1
    @nav_item1.should_receive(:update_attributes).and_return false
    post 'update', :church_id => @church.slug, :id => @nav_item1.id
    flash[:error].should == "Nav Item could not be updated"
    response.should render_template "edit"
  end
  
  it "should destroy the nav item and return to the index page" do
    lambda do
      delete 'destroy', :id => @nav_item1.id
      response.should redirect_to edit_nav_menu_path(@church, @nav_item1.nav_menu)
    end.should change(NavItem, :count).by(-1)
  end
  
end
