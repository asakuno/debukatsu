class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :integer, default: nil
    add_column :users, :gender, :integer, default: nil
    add_column :users, :weight, :integer, default: nil
  end
end
