class CreateSellBookItems < ActiveRecord::Migration
  def change
    create_table :sell_book_items do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :campus_id
      t.decimal :price, precision: 5, scale: 2
      t.string :condition
      t.string :condition_description

      t.timestamps
    end
  end
end
