class AddRemoteImageToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :remote_image_url, :string
  end
end
