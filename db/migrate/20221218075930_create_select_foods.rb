class CreateSelectFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :select_foods do |t|
      t.references :food, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
    add_index  :select_foods, [:food_id, :group_id], unique: true
  end
end
