class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :integer, null: false
    add_column :users, :gender, :integer, null: false
    add_column :users, :weight, :integer, null: false
  end
end
