#require File.dirname(__FILE__) + '/../spec_helper'
require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe PeopleController do
  
  describe "when not logged in" do
  
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @person = Factory(:person)
    end
    
    it "should block the edit page" do
      get 'edit', :church_id => @institution.slug, :id => @person.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should block the new page" do
      get 'new', :church_id => @institution.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
    it "should block the index page" do
      get 'index', :church_id => @institution.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should allow the show page" do
      get 'show', :church_id => @institution.slug, :id => @person.id
      response.should be_success
    end

  end

  describe "when logged in" do
  
    before(:each) do
      setup_site
      @institution = @root
      @request.host = 'www.example.com'
      controller.stub!(:signed_in?).and_return true
      @person = Factory(:person, :parish_id => @root.id)
    end
  
    it "should allow the edit page" do
      get 'edit', :church_id => @institution.slug, :id => @person.id
      response.should be_success
    end

    it "should allow the new page" do
      get 'new', :church_id => @institution.slug
      response.should be_success
    end

    it "should allow the new page" do
      get 'index', :church_id => @institution.slug
      response.should be_success
    end

    it "should correctly redirect and increase the person count when creating a person" do
      lambda do
        post 'create', :person => Factory.attributes_for(:person)
        response.should be_redirect
        response.location.should include people_path(@institution)
      end.should change(Person, :count).by(1)
    end

    it "should display an error message and render the new action if person is not valid on create" do
      Person.should_receive(:new).and_return(@person)
      @person.should_receive(:save).and_return(false)
      lambda do
        post 'create', :person => Factory.attributes_for(:person)
        flash[:error].should == "There was an error creating the person"
        response.should render_template('new')
      end.should_not change(Person, :count)
    end
    
    it "should correctly redirect and decrease the person count when deleting an person" do
      lambda do
        delete 'destroy', :church_id => @institution.slug, :id => @person.id
        response.should be_redirect
        response.location.should include people_path(@root)
      end.should change(Person, :count).by(-1)
    end
    
    it "should handle the update of an person" do
      Person.should_receive(:find).and_return(@person)
      @person.should_receive(:update_attributes).and_return true
      put 'update', :id => @person.id, :person => Factory.attributes_for(:person)
      response.should be_redirect
      response.location.should include people_path(@root)
    end

    it "should display an error message and render the edit action if person is not valid on update" do
      Person.should_receive(:find).and_return @person     
      @person.should_receive(:update_attributes).and_return(false)
      put 'update', :id => @person.id, :church_id => @institution.slug, :person => Factory.attributes_for(:person)
      flash[:error].should == 'There was an error updating the person'
      response.should render_template('edit')
    end

  end
  
end