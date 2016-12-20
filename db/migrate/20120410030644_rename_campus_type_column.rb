class RenameCampusTypeColumn < ActiveRecord::Migration
  def up
  	rename_column :campus, :type, :school_type
  end

  def down
  	rename_column :campus, :school_type, :type
  end
end
