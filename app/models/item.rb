class Item < ApplicationRecord
  has_many :votes, as: :votable
  belongs_to :item_group,  inverse_of: :items

  has_many :upvoted_users, through: :votes, source: :user

  validates :name, presence: true, length: { maximum: 50 }
end
