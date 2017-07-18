class Item < ApplicationRecord
  has_many :votes, as: :votable
  belongs_to :item_group

  has_many :upvoted_users, through: :votes, source: :user
end
