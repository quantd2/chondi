class AddImageProcessingToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :image_processing, :boolean, null: false, default: false
  end
end
