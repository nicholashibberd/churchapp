require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe NavMenusController do
  
  describe "when not logged in" do
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @nav_menu = Factory(:nav_menu, :church_id => @institution.id)
    end

    it "should not allow access to the new action" do
      get 'new', :church_id => @institution.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should not allow access to the edit action" do
      get 'edit', :church_id => @institution.slug, :id => @nav_menu.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should not allow access to the index action" do
      get 'index', :church_id => @institution.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
  end

  describe "when logged in" do
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @nav_menu = Factory(:nav_menu, :church_id => @institution.id)
      @nav_item1 = Factory(:nav_item, :nav_menu_id => @nav_menu.id, :name => "Nav Item 1")
      @nav_item2 = Factory(:nav_item, :nav_menu_id => @nav_menu.id, :name => "Nav Item 2")
      controller.stub!(:signed_in?).and_return true
    end

    it "should allow access to the new action" do
      get 'new', :church_id => @institution.slug
      response.should be_success
    end

    it "should allow access to the edit action" do
      get 'edit', :church_id => @institution.slug, :id => @nav_menu.id
      response.should be_success
    end

    it "should allow access to the index action" do
      get 'index', :church_id => @institution.slug
      response.should be_success
    end
    
    it "should create nav_menu and redirect when valid" do
      lambda do
        post 'create', :church_id => @institution.slug, :nav_menu => Factory.attributes_for(:nav_menu).merge(:church_id => @institution.id)
        response.should be_redirect
        response.location.should include nav_menus_path(@nav_menu.church)
      end.should change(NavMenu, :count).by(1)
    end
        
    it "should display flash message and render new action when invalid" do
      lambda do
        NavMenu.should_receive(:new).and_return @nav_menu
        @nav_menu.should_receive(:save).and_return false
        post 'create', :church_id => @institution.slug, :nav_menu => Factory.attributes_for(:nav_menu).merge(:church_id => @institution.id)
        flash[:error].should == "Nav Menu could not be created"
        response.should render_template "new"
      end.should_not change(NavItem, :count)
    end

    it "should update nav_menu and redirect when valid" do
      NavMenu.should_receive(:find).and_return @nav_menu
      @nav_menu.should_receive(:update_attributes).and_return true
      post 'update', :church_id => @institution.slug, :id => @nav_menu.id
      response.should be_redirect
      response.location.should include nav_menus_path(@nav_menu.church)
    end

    it "should display flash message and render edit action when invalid" do
      NavMenu.should_receive(:find).and_return @nav_menu
      @nav_menu.should_receive(:update_attributes).and_return false
      post 'update', :church_id => @institution.slug, :id => @nav_menu.id
      flash[:error].should == "Nav Menu could not be updated"
      response.should render_template "edit"
    end

    it "should destroy the nav menu and return to the index page" do
      lambda do
        delete 'destroy', :id => @nav_menu.id
        response.should redirect_to nav_menus_path(@institution)
      end.should change(NavMenu, :count).by(-1)
    end
    
    it "should redirect the order of the nav items" do
      post 'order_nav_items', :id => @nav_menu.id, :navitem => [@nav_item2.id.to_s, @nav_item1.id.to_s]
      @nav_menu.nav_items.asc(:position).first.should eql @nav_item2
    end

    
  end
  
end
