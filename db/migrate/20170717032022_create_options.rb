class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.belongs_to :poll, index: true
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
