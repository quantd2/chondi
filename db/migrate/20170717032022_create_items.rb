class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.belongs_to :item_group, index: true
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
