class ItemGroup < ApplicationRecord
  has_many :items
  has_many :comments, as: :commentable
  belongs_to :user
end
