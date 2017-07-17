class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :group_items, foreign_key: true, index: true
      t.text :name

      t.timestamps
    end
  end
end
