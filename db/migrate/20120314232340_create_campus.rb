class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campus do |t|
      t.string :name
      t.string :city
      t.string :type

      t.timestamps
    end
  end
end
