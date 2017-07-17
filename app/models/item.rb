class Item < ApplicationRecord
  has_many :votes, as: :votable
  belongs_to :item_group
end
