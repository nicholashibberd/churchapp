require 'test_helper'

class NavItemsControllerTest < ActionController::TestCase
  setup do
    @nav_item = nav_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nav_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nav_item" do
    assert_difference('NavItem.count') do
      post :create, :nav_item => @nav_item.attributes
    end

    assert_redirected_to nav_item_path(assigns(:nav_item))
  end

  test "should show nav_item" do
    get :show, :id => @nav_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @nav_item.to_param
    assert_response :success
  end

  test "should update nav_item" do
    put :update, :id => @nav_item.to_param, :nav_item => @nav_item.attributes
    assert_redirected_to nav_item_path(assigns(:nav_item))
  end

  test "should destroy nav_item" do
    assert_difference('NavItem.count', -1) do
      delete :destroy, :id => @nav_item.to_param
    end

    assert_redirected_to nav_items_path
  end
end
