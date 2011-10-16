require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe MessagesController do
    
  describe "when not logged in" do
    
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @message = Factory(:message, :church_id => @church.id)
      @page = Factory(:page)      
    end

    it "should restrict access to the index action" do
      get 'index', :church_id => @church.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
    it "should restrict access to the show action" do
      get 'show', :church_id => @church.slug, :id => @message.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
    it "should handle the create and redirect back to the previous page when valid" do
      Message.should_receive(:new).and_return @message
      Page.should_receive(:find).and_return @page
      @message.should_receive(:save).and_return true
      post 'create', :message => Factory.attributes_for(:message), :page_id => @page.id, :church_id => @church.slug
      response.should be_redirect
      response.location.should include church_page_path(@church, @page)
    end 

  end

  describe "when logged in" do
    
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @page = Factory(:page)
      @message = Factory(:message, :church_id => @church.id)
      controller.stub!(:signed_in?).and_return true
    end

    it "should show all the messages" do
      get 'index', :church_id => @church.slug
      response.should be_success
    end

    it "should render the show action" do
      get 'show', :church_id => @church.slug, :id => @message.id
      response.should be_success
    end
    
    it "should return a flash message when invalid" do
      Message.should_receive(:new).and_return @message
      @message.should_receive(:save).and_return false
      post 'create', :message => Factory.attributes_for(:message), :page_id => @page.id, :church_id => @church.slug
      flash[:notice].should == "There was an error sending this message"
      response.location.should include church_page_path(@church, @page)
    end
    
    it "should destroy the message and return to the index page" do
      lambda do
        delete 'destroy', :id => @message.id
        response.should redirect_to messages_path(@church)
      end.should change(Message, :count).by(-1)
    end

  end

end
