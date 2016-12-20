class AddPriceToBooks < ActiveRecord::Migration
  def change
    add_column :books, :pricenew, :decimal, :precision => 5, :scale => 2
    add_column :books, :priceused, :decimal, :precision => 5, :scale => 2
  end
end
