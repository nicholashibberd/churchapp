require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe EventsController do
  
  describe "when not logged in" do
    
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @event = Factory(:event)
    end
    
    it "should restrict access to the index action" do
      get 'index', :church_id => @church.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end  

    it "should restrict access to the new action" do
      get 'new', :church_id => @church.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end  

    it "should restrict access to the edit action" do
      get 'edit', :church_id => @church.slug, :id => @event.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
    it "should not restrict access to the show action" do
      get 'show', :church_id => @church.slug, :id => @event.id
      response.should be_success
    end
  end
  
  describe "when logged in" do

    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      controller.stub!(:signed_in?).and_return true
      @event = Factory(:event, :church_id => @church.id)
    end
    
    it "should allow access to the index action" do
      get 'index', :church_id => @church.slug
      response.should be_success    
    end

    it "should allow access to the new action" do
      get 'new', :church_id => @church.slug
      response.should be_success    
    end

    it "should allow access to the edit action" do
      get 'edit', :church_id => @church.slug, :id => @event.id
      response.should be_success    
    end
    
    it "should correctly redirect and increase the event count when creating an event" do
      lambda do
        post 'create', :event => Factory.attributes_for(:event), :church_id => @church.slug
        response.should be_redirect
        response.location.should include events_path(@church)
      end.should change(Event, :count).by(1)
    end

    it "should create multiple events when event series is specified" do
      @event_series = Factory(:event_series)
      EventSeries.should_receive(:create).and_return @event_series
      post 'create', :event => Factory.attributes_for(:event).merge(:period => 'Weekly'), :church_id => @church.slug
      @event_series.events.count.should eql 2
      response.should be_redirect      
      response.location.should include events_path(@church)
    end

    it "should correctly redirect and handle the update of an event when valid" do
      Event.should_receive(:find).and_return @event
      @event.should_receive(:update_attributes).and_return true
      put 'update', :church_id => @church.slug, :id => @event.id
      response.should be_redirect
      response.location.should include events_path(@church)
    end
    
    it "should render the edit action and display a flash message when invalid" do
      Event.should_receive(:find).and_return @event
      @event.should_receive(:update_attributes).and_return false
      put 'update', :church_id => @church.slug, :id => @event.id
      flash[:error].should == 'There was an error updating the event'
      response.should render_template('edit')
    end
    
    it "should correctly redirect and decrease the event count when deleting an event" do
      lambda do
        delete 'destroy', :church_id => @church.slug, :id => @event.id
        response.should be_redirect
        response.location.should include events_path(@church)
      end.should change(Event, :count).by(-1)
    end
    
  end
end
