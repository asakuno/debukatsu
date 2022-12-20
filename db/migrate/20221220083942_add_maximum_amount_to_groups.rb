class AddMaximumAmountToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :maximum_amount, :integer, null: false
  end
end
