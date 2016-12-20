require 'test_helper'

class BookTransactionsControllerTest < ActionController::TestCase
  setup do
    @book_transaction = book_transactions(:one)
  end

  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:books_to_buy)
  end

=begin
  test "should get new" do
    sign_in users(:one)

    book = books(:one)
    book.save

    get(:new, {:buy_book => book.id})
    assert_response :success
    #assert_not_nil assigns(:book)
  end
=end

  test "should create book_transaction" do
    sign_in users(:one)

    sell_book_item = sell_book_items(:one)
    sell_book_item.save

    assert_difference('BookTransaction.count') do
      post :create, book_transaction: @book_transaction.attributes, buy_book: sell_book_item.id
    end

    assert_redirected_to book_transaction_path(assigns(:book_transaction))
  end

  test "should show book_transaction" do
    sign_in users(:one)
    get :show, id: @book_transaction
    assert_response :success
  end

=begin

  test "should get edit" do
    sign_in users(:one)
    get :edit, id: @book_transaction
    assert_response :success
  end

  test "should update book_transaction" do
    sign_in users(:one)
    put :update, id: @book_transaction, book_transaction: @book_transaction.attributes
    assert_redirected_to book_transaction_path(assigns(:book_transaction))
  end

  test "should destroy book_transaction" do
    sign_in users(:one)
    assert_difference('BookTransaction.count', -1) do
      delete :destroy, id: @book_transaction
    end

    assert_redirected_to book_transactions_path
  end

=end

end
