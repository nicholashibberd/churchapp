#require File.dirname(__FILE__) + '/../spec_helper'
require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe CategoriesController do
  
  describe "categories controller should handle the request correctly" do
    
    it "should return the correct articles when the category is requested" do
      setup_site
      @request.host = 'www.example.com'
      @category = Factory(:category)
      @article1 = Factory(:article)
      @article2 = Factory(:article)
      @category.articles << [@article1, @article2]
      Category.should_receive(:find_by_slug).and_return(@category)
      @category.should_receive(:find_articles_by_church).and_return([@article1, @article2])
      get 'category_articles', :category_id => @category.id, :church_id => @church.id
      response.should be_success
    end
    
  end
  
end
