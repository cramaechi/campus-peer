class RemoveSchooltypeFromCampus < ActiveRecord::Migration
  def up
  	remove_column :campus, :state
  	remove_column :campus, :school_type

  	add_column :campus, :city, :string
  	add_column :campus, :state, :string
  end

  def down
  	remove_column :campus, :state
  	remove_column :campus, :city

  	add_column :campus, :state, :string
  	add_column :campus, :school_type, :string
  end
end
