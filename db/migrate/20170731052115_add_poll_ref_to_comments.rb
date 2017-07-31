class AddPollRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :poll, index: true
  end
end
