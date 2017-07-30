class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.belongs_to :user, index: true
      t.integer :reportable_id
      t.string :reportable_type

      t.timestamps
    end
  end
end
