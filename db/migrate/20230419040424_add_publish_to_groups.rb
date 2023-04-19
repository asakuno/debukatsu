class AddPublishToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :publish, :boolean, null: false, default: true
  end
end
