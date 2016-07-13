require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Search"
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { age: @item.age, deposit: @item.deposit, location: @item.location, max_loan_period: @item.max_loan_period, min_loan_period: @item.min_loan_period, model: @item.model, name: @item.name, rental_rate: @item.rental_rate, type: @item.type }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { age: @item.age, deposit: @item.deposit, location: @item.location, max_loan_period: @item.max_loan_period, min_loan_period: @item.min_loan_period, model: @item.model, name: @item.name, rental_rate: @item.rental_rate, type: @item.type }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end