class AddPriceToFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :price, :integer, null: false
  end
end
