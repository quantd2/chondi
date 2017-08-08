class AddIndexSearchIndexToPolls < ActiveRecord::Migration[5.0]
  def up
    execute "create index polls_name on polls using gin(to_tsvector('simple', name))"
  end

  def down
    execute "drop index polls_name"
  end
end
