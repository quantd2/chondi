class AddVotesCounterToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :votes_count, :integer

    Item.reset_column_information
    Item.all.each do |i|
      i.update_attribute :votes_count, i.votes.length
    end
  end
end
