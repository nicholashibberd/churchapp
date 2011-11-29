require 'integration_spec_helper'
require 'spec_helper'

describe "Pages" do
  describe "should ask for login credentials at the correct time" do  
    
    before(:each) do 
      setup_site
      @page = Factory(:page, :church_id => @institution.id)
    end
  
    it "should not ask for login on a show page" do
      visit church_page_path(@institution, @page)
      response.should be_success
    end

    it "should ask for login on an edit page if the user is not logged in" do
      visit edit_page_path(@institution, @page)
      response.should contain("Please login to continue")
    end

    it "should not ask for login on an edit page if the user is logged in" do
      login_user_blank
      visit edit_page_path(@institution, @page)
      response.should_not contain("Please login to continue")
    end
  end
end