class CreateBookTransactions < ActiveRecord::Migration
  def change
    create_table :book_transactions do |t|
      t.integer :sell_book_item_id
      t.integer :book_id
      t.integer :seller_user_id
      t.integer :buyer_user_id
      t.integer :campus_id
      t.decimal :price, precision: 5, scale: 2
      t.string :condition
      t.string :condition_description
      t.string :peertag

      t.timestamps
    end
  end
end
