class Campus < ActiveRecord::Base
  has_many :users
  has_many :sell_book_items
  has_many :book_transactions
  has_many :most_wanted_books

end
