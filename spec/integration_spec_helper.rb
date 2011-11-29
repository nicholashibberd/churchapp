require 'spec_helper'

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

def login_user_blank(email = 'test@test1.com', password = 'password')
  setup_site
  user = Factory(:user, {:email => email, :password => password})
  visit signin_url
  fill_in "Email",        :with => email
  fill_in "Password",     :with => password
  click_button
end

def setup_site
  @site = Factory(:site)
  @root = Factory(:parish, :site_id => @site.id)
  @institution = Factory(:church, :parish_id => @root.id, :site_id => @site.id)
end