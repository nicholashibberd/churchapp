require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe PagesController do
  
  describe "when not logged in" do
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @page = Factory(:page, :church_id => @church.id)
    end

    it "should not allow access to the new action" do
      get 'new', :church_id => @church.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should not allow access to the edit action" do
      get 'edit', :church_id => @church.id, :id => @page.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should not allow access to the index action" do
      get 'index', :church_id => @church.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
    it "should allow access to the show action" do
      get 'show', :church_id => @church.id
      response.should be_success
    end
    
  end
  
  describe "when not logged in" do
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @page = Factory(:page, :church_id => @church.id)
      controller.stub!(:signed_in?).and_return true
    end
    
    it "should allow access to the new action" do
      get 'new', :church_id => @church.slug
      response.should be_success
    end

    it "should allow access to the edit action" do
      get 'edit', :church_id => @church.slug, :id => @page.id
      response.should be_success
    end

    it "should allow access to the index action" do
      get 'index', :church_id => @church.slug
      response.should be_success
    end
    
    it "should create page and redirect when valid" do
      lambda do
        post 'create', :church_id => @church.slug, :page => Factory.attributes_for(:page).merge(:church_id => @church.id, :name => "Test page 2")
        response.should be_redirect
        response.location.should include pages_path(@page.church)
      end.should change(Page, :count).by(1)
    end

    it "should not create page and render new action when invalid" do
      page = Page.new
      Page.should_receive(:new).and_return page
      page.should_receive(:save).and_return false
      lambda do
        post 'create', :church_id => @church.slug, :page => Factory.attributes_for(:page).merge(:church_id => @church.id, :name => "Test page 2")
        flash[:error].should == 'Page could not be created'
        response.should render_template 'new'
      end.should_not change(Page, :count)
    end
    
    it "should update page and redirect when valid" do
      Church.any_instance.stub(:find_page).and_return @page
      @page.should_receive(:update_attributes).and_return true
      post 'update', :church_id => @church.slug, :id => @page.slug
      response.should be_redirect
      response.location.should include pages_path(@page.church)
    end

    it "should not update page and render edit action when invalid" do
      Church.any_instance.stub(:find_page).and_return @page
      @page.should_receive(:update_attributes).and_return false
      post 'update', :church_id => @church.slug, :id => @page.slug
      flash[:error].should == 'Page could not be updated'
      response.should render_template 'edit'
    end
    
    it "should correctly redirect and decrease the page count when deleting an article" do
      lambda do
        delete 'destroy', :church_id => @church.slug, :id => @page.slug
        response.should be_redirect
        response.location.should include pages_path(@church)
      end.should change(Page, :count).by(-1)
    end
    
    it "should redirect the order of the widgets" do
      @map_widget = Factory(:map_widget, :page_id => @page.id)
      @content_widget = Factory(:content_widget, :page_id => @page.id)
      post 'order_widgets', :id => @page.id, :widget => [@content_widget.id.to_s, @map_widget.id.to_s]
      @page.widgets.asc(:position).first.should eql @content_widget
    end
    
    
  end
  
end