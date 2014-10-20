require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { notes: @order.notes, ordered_at: @order.ordered_at, paid_for_by: @order.paid_for_by, reimbursed: @order.reimbursed, shipping_cost: @order.shipping_cost, status: @order.status, tax_cost: @order.tax_cost, vendor_name: @order.vendor_name }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    put :update, id: @order, order: { notes: @order.notes, ordered_at: @order.ordered_at, paid_for_by: @order.paid_for_by, reimbursed: @order.reimbursed, shipping_cost: @order.shipping_cost, status: @order.status, tax_cost: @order.tax_cost, vendor_name: @order.vendor_name }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
