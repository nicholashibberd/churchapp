require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Photo.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Photo.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to photos_url
  end

  def test_edit
    get :edit, :id => Photo.first
    assert_template 'edit'
  end

  def test_update_invalid
    Photo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Photo.first
    assert_template 'edit'
  end

  def test_update_valid
    Photo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Photo.first
    assert_redirected_to photos_url
  end
end
