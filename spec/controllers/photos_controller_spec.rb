require 'spec_helper.rb'
require 'integration_spec_helper.rb'

describe PhotosController do

  describe "when not logged in" do
  
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      @photo = Factory(:photo, :institution_id => @institution.id)
    end
    
    it "should block the edit page" do
      get 'edit', :church_id => @institution.slug, :id => @photo.id
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

  end
  
  describe "when logged in" do
    before(:each) do
      setup_site
      @request.host = 'www.example.com'
      controller.stub!(:signed_in?).and_return true
      @photo = Factory(:photo, :institution_id => @institution.id)      
    end
    
    it "should allow the edit page" do
      get 'edit', :church_id => @institution.slug, :id => @photo.id
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

    it "should correctly redirect and increase the photo count when creating a photo" do
      lambda do
        post 'create', :photo => Factory.attributes_for(:photo).merge(:institution_id => @institution.id)
        response.should be_redirect
        response.location.should include photos_path(@institution)
      end.should change(Photo, :count).by(1)
    end

    it "should display an error message and render the new action if photo is not valid on create" do
      Photo.should_receive(:new).and_return(@photo)
      @photo.should_receive(:save).and_return(false)
      lambda do
        post 'create', :photo => Factory.attributes_for(:photo).merge(:institution_id => @institution.id)
        flash[:error].should == "There was an error creating the photo"
        response.should render_template('new')
      end.should_not change(Photo, :count)
    end
    
    it "should correctly redirect and decrease the photo count when deleting an photo" do
      lambda do
        delete 'destroy', :church_id => @institution.slug, :id => @photo.id
        response.should be_redirect
        response.location.should include photos_path(@institution)
      end.should change(Photo, :count).by(-1)
    end
    
    it "should handle the update of an photo" do
      Photo.should_receive(:find).and_return(@photo)
      @photo.should_receive(:update_attributes).and_return true
      put 'update', :id => @photo.id, :photo => Factory.attributes_for(:photo).merge(:institution_id => @institution.id), :church_id => @institution.slug
      response.should be_redirect
      response.location.should include photos_path(@institution)
    end

    it "should display an error message and render the edit action if photo is not valid on update" do
      Photo.should_receive(:find).and_return @photo    
      @photo.should_receive(:update_attributes).and_return(false)
      put 'update', :id => @photo.id, :church_id => @institution.slug, :photo => Factory.attributes_for(:photo).merge(:institution_id => @institution.id)
      flash[:error].should == 'There was an error updating the photo'
      response.should render_template('edit')
    end
    
    it "should change the order of the photos" do
      @photo1 = Factory(:photo, :institution_id => @institution.id)
      @photo2 = Factory(:photo, :institution_id => @institution.id)
      post 'order_photos', :photo => [@photo2.id.to_s, @photo1.id.to_s]
      @institution.photos.asc(:position).first.should eql @photo2
    end
    
  end

end
