require 'test_helper'

class BookTransactionTest < ActiveSupport::TestCase
  test "book transaction attributes must be present" do
  	book_transaction = BookTransaction.new

  	assert book_transaction.invalid?
  	assert book_transaction.errors[:sell_book_item_id].include?("can't be blank")
    assert book_transaction.errors[:book_id].include?("can't be blank")
    assert book_transaction.errors[:seller_user_id].include?("can't be blank")
  	assert book_transaction.errors[:buyer_user_id].include?("can't be blank")
  	assert book_transaction.errors[:campus_id].include?("can't be blank")
  	assert book_transaction.errors[:price].include?("can't be blank")
  	assert book_transaction.errors[:condition].include?("can't be blank")
  	assert book_transaction.errors[:peertag].include?("can't be blank")
  end
end
