class AddItemGroupToItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :item_group, foreign_key: true
    remove_column :items, :group_item_id
  end
end
