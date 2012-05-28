require 'test_helper'

class ParksControllerTest < ActionController::TestCase
  setup do
    @park = parks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create park" do
    assert_difference('Park.count') do
      post :create, park: @park.attributes
    end

    assert_redirected_to park_path(assigns(:park))
  end

  test "should show park" do
    get :show, id: @park.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @park.to_param
    assert_response :success
  end

  test "should update park" do
    put :update, id: @park.to_param, park: @park.attributes
    assert_redirected_to park_path(assigns(:park))
  end

  test "should destroy park" do
    assert_difference('Park.count', -1) do
      delete :destroy, id: @park.to_param
    end

    assert_redirected_to parks_path
  end
end
