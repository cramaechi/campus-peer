require 'test_helper'

class SellBookItemsControllerTest < ActionController::TestCase

  setup do
    sign_in users(:one)
    @sell_book_item = sell_book_items(:one)
  end

  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    sign_in users(:one)
    get(:new, {'book' => 1}, nil)
    assert_response :success
    assert_not_nil assigns(:book_to_be_sold)
    assert_not_nil assigns(:sell_book_item)
  end

  test "should create sell_book_item" do
    sign_in users(:one)
    assert_difference('SellBookItem.count') do
      post :create, sell_book_item: @sell_book_item.attributes
    end

    assert_redirected_to sell_book_item_path(assigns(:sell_book_item))
  end

  test "should show sell_book_item" do
    sign_in users(:one)
    get :show, id: @sell_book_item
    assert_response :success
    assert_not_nil assigns(:book_to_be_sold)
    assert_not_nil assigns(:sell_book_item)
  end

  test "should get edit" do
    sign_in users(:one)
    get :edit, id: @sell_book_item
    assert_response :success
    assert_not_nil assigns(:book_to_be_sold)
    assert_not_nil assigns(:sell_book_item)
  end

  test "should update sell_book_item" do
    sign_in users(:one)
    put :update, id: @sell_book_item, sell_book_item: @sell_book_item.attributes
    assert_redirected_to sell_book_item_path(assigns(:sell_book_item))
  end

  test "should destroy sell_book_item" do
    sign_in users(:one)
    assert_difference('SellBookItem.count', -1) do
      delete :destroy, id: @sell_book_item
    end

    assert_redirected_to sell_book_items_path
  end
end
