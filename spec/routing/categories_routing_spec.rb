require 'spec_helper'
require 'integration_spec_helper'

describe "routes to the categories controller" do
  it "routes a named route" do
    setup_site
    @category = Factory(:category)
    
    {:get => category_articles_path(@institution, @category)}.
      should route_to(:controller => "categories", :action => "category_articles", :church_id => @institution.slug, :category_id => @category.slug)
  end
end