class CreateItemGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :item_groups do |t|
      t.text :name
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
