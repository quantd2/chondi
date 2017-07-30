class AddIndexToReports < ActiveRecord::Migration[5.0]
  def change
    add_index :reports, [:reportable_type, :reportable_id], unique: true
  end
end
