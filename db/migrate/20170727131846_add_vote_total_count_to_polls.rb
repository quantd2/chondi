class AddVoteTotalCountToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :vote_count, :integer, default: 0

    Poll.reset_column_information
    Poll.all.each do |p|
      p.update_attribute :vote_count, p.votes_summary
    end
  end
end
