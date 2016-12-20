class AddUniqueIndexToBooks < ActiveRecord::Migration
  def change
    add_index :books, :isbn10, :unique => true
    add_index :books, :isbn13, :unique => true
  end
end
