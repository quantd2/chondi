class AddImageToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :image, :string
  end
end
