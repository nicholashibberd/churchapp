require 'test_helper'

class NavMenusControllerTest < ActionController::TestCase
  setup do
    @nav_menu = nav_menus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nav_menus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nav_menu" do
    assert_difference('NavMenu.count') do
      post :create, :nav_menu => @nav_menu.attributes
    end

    assert_redirected_to nav_menu_path(assigns(:nav_menu))
  end

  test "should show nav_menu" do
    get :show, :id => @nav_menu.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @nav_menu.to_param
    assert_response :success
  end

  test "should update nav_menu" do
    put :update, :id => @nav_menu.to_param, :nav_menu => @nav_menu.attributes
    assert_redirected_to nav_menu_path(assigns(:nav_menu))
  end

  test "should destroy nav_menu" do
    assert_difference('NavMenu.count', -1) do
      delete :destroy, :id => @nav_menu.to_param
    end

    assert_redirected_to nav_menus_path
  end
end
