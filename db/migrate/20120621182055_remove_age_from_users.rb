class RemoveAgeFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :age
  end

  def down
  	add_column :users, :age, :string
  end
end
