class AddRemoteImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :remote_image_url, :string
  end
end
