require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe CommentsController do
  
  before(:each) do
    setup_site
    @request.host = 'www.example.com'
    @article = Factory(:article)
    @comment = Factory(:comment)
    raise @comment.inspect
    @article.comments << @comment
  end
  
  describe "when logged in" do
      
    it "should request login credentials before allowing the edit request" do
      get 'edit', :article_id => @article.id, :id => @comment.id, :church_id => @church.slug
      response.should be_redirect
      response.location.should == 'http://www.example.com/signin'
    end
  end

end
