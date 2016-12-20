require 'test_helper'

class SellBookItemTest < ActiveSupport::TestCase
  test "sell book item attributes must be present" do
  	sell_book_item = SellBookItem.new

  	assert sell_book_item.invalid?
  	assert sell_book_item.errors[:user_id].include?("can't be blank")
    assert sell_book_item.errors[:book_id].include?("can't be blank")
    assert sell_book_item.errors[:campus_id].include?("can't be blank")
  	assert sell_book_item.errors[:price].include?("can't be blank")
  	assert sell_book_item.errors[:condition].include?("can't be blank")
  end

  test "price must be between one cent and two thousand" do
  	sell_book_item = sell_book_items(:one)
    sell_book_item.price = 0;

  	sell_book_item.save
  	assert sell_book_item.errors[:price].include?("must be greater than or equal to 0.01")

  	sell_book_item.price = 2001
  	sell_book_item.save
  	assert sell_book_item.errors[:price].include?("must be less than or equal to 2000")

  	sell_book_item.price = 100.01
  	sell_book_item.save
  	assert sell_book_item.valid?
  end

  def new_sell_book_item(price)
  	sell_book_item = sell_book_items(:one)
    sell_book_item.price = price
  	sell_book_item.save
  	sell_book_item
  end

  test "must be a valid price" do
    good = [20.00, 13.3, 1, 0.01, 1000, 2000, 13.30, 13.120]
  	bad = [0.001, 1.326]

  	good.each do |price|
  	  assert new_sell_book_item(price).valid?
  	end

  	bad.each do |price|
  	  assert new_sell_book_item(price).errors[:price].include?("must be in a valid format (d.dd)")
  	end
  end

  test "condition description must be less than 255 in length" do
  	sell_book_item = sell_book_items(:one)
  	sell_book_item.condition_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ipsum elit, varius eu mattis non, luctus vitae odio. Vivamus ultrices est purus, nec sollicitudin nisi. Donec eget diam mi. Aenean erat eros, viverra eget mollis vel, rhoncus sit amet amet.d"
  	sell_book_item.save
  	assert sell_book_item.errors[:condition_description].include?("is too long (maximum is 255 characters)")

  	sell_book_item.condition_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ipsum elit, varius eu mattis non, luctus vitae odio. Vivamus ultrices est purus, nec sollicitudin nisi. Donec eget diam mi. Aenean erat eros, viverra eget mollis vel, rhoncus sit amet amet."
  	sell_book_item.save
  	assert sell_book_item.valid?
  end

  test "condition must be a provided value" do
  	sell_book_item = sell_book_items(:one)
    sell_book_item.condition = "Kinda Used"
  	sell_book_item.save
  	assert sell_book_item.errors[:condition].include?("must be a valid condition")

  	sell_book_item.condition = "Used"
  	sell_book_item.save
  	assert sell_book_item.valid?

  	sell_book_item.condition = "New"
  	sell_book_item.save
	assert sell_book_item.valid?  	  	
  end
end
