class AddColumnsToFoods < ActiveRecord::Migration[6.1]
  def change 
    add_column :foods, :protein, :float
    add_column :foods, :lipid, :float
    add_column :foods, :sugar, :float
    add_column :foods, :dietary_fiber, :float
    add_column :foods, :table_salt, :float
  end
end
