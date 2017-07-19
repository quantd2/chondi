class ChangeNameToStrong < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :name, :string
    change_column :item_groups, :name, :string
  end
end
