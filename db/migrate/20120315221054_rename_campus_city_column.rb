class RenameCampusCityColumn < ActiveRecord::Migration
  def up
  	rename_column :campus, :city, :state
  end

  def down
  	rename_column :campus, :state, :city
  end
end
