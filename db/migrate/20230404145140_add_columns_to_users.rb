class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :integer
    add_column :users, :weight, :integer
  end
end
