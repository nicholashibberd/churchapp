#require File.dirname(__FILE__) + '/../spec_helper'
require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe ArticlesController do
  
  describe "when not logged in" do
  
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @article = Factory(:article)
    end
    
    it "should route single article path to show" do
      { :get => '/all-saints/articles/12345' }.should route_to(:controller => 'articles', :action => 'show', :id => '12345', :church_id => 'all-saints')
    end
  
    it "should block the edit page" do
      get 'edit', :church_id => @church.slug, :id => @article.id
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

    it "should block the new page" do
      get 'new', :church_id => @church.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
    
    it "should block the index page" do
      get 'index', :church_id => @church.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end

  end

  describe "when logged in" do
  
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      controller.stub!(:signed_in?).and_return true
      @article = Factory(:article, :church_id => @church.id)
    end
  
    it "should allow the show page" do
      get 'show', :church_id => @church.slug, :id => @article.id
      response.should be_success
    end

    it "should allow the edit page" do
      get 'edit', :church_id => @church.slug, :id => @article.id
      response.should be_success
    end

    it "should allow the new page" do
      get 'new', :church_id => @church.slug
      response.should be_success
    end

    it "should correctly redirect and increase the article count when creating an article" do
      lambda do
        post 'create', :article => Factory.attributes_for(:article)
        response.should be_redirect
        response.location.should include articles_path
      end.should change(Article, :count).by(1)
    end

    it "should display an error message and render the new action if article is not valid on create" do
      Article.should_receive(:new).and_return(@article)
      @article.should_receive(:save).and_return(false)
      lambda do
        post 'create', :article => Factory.attributes_for(:article)
        flash[:error].should == "There was an error creating the article"
        response.should render_template('new')
      end.should_not change(Article, :count)
    end
    
    it "should correctly redirect and decrease the article count when deleting an article" do
      lambda do
        delete 'destroy', :church_id => @church.slug, :id => @article.id
        response.should be_redirect
        response.location.should include articles_path(@church)
      end.should change(Article, :count).by(-1)
    end
    
    it "should handle the update of an article" do
      Article.should_receive(:find).and_return(@article)
      Church.should_receive(:find).and_return @church
      @article.should_receive(:update_attributes).and_return true
      put 'update', :id => @article.id, :church_id => @church.slug, :article => Factory.attributes_for(:article)
      response.should be_redirect
      response.location.should include articles_path(@church)
    end

    it "should display an error message and render the edit action if article is not valid on update" do
      Article.should_receive(:find).and_return @article
      Church.should_receive(:find).and_return @church      
      @article.should_receive(:update_attributes).and_return(false)
      put 'update', :id => @article.id, :church_id => @church.slug, :article => Factory.attributes_for(:article)
      flash[:error].should == 'There was an error updating the article'
      response.should render_template('edit')
    end

  end
  
end