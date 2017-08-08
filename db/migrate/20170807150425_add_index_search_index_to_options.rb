class AddIndexSearchIndexToOptions < ActiveRecord::Migration[5.0]
  def up
    execute "create index options_name on options using gin(to_tsvector('simple', name))"
  end

  def down
    execute "drop index options_name"
  end
end
