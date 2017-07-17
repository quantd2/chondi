class AddVotesCounterToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :votes_count, :integer

    Comment.reset_column_information
    Comment.all.each do |c|
      c.update_attribute :votes_count, c.votes.length
    end
  end
end
