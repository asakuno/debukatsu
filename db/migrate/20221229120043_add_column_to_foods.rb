class AddColumnToFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :image_data, :text
  end
end
