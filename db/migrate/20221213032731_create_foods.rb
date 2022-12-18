class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :food_name, null: false
      t.integer :calorie, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
