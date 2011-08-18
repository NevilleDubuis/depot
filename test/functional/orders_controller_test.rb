require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
    @update = {
      :name        => "lorem Ipsum",
      :addresse    => "wibbles are fun!",
      :pay_type    => "Check",
      :created_at  => "2011-08-18 08:21:13.447779"
    }
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :redirect
  end

  test "should create order" do
    assert_difference('Order.count', 0) do
      post :create, order: @update
    end

    assert_response :success
  end

  test "should show order" do
    get :show, id: @order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order.to_param
    assert_response :success
  end

  test "should update order" do
    put :update, id: @order.to_param, order: @order.attributes
    assert_response :success
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order.to_param
    end

    assert_redirected_to orders_path
  end
end
