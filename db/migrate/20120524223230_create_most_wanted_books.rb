class CreateMostWantedBooks < ActiveRecord::Migration
  def change
    create_table :most_wanted_books do |t|
      t.integer :book_id
      t.integer :campus_id
      t.integer :want

      t.timestamps
    end
  end
end
