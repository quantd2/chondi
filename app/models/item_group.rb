class ItemGroup < ApplicationRecord
  has_many :items
  accepts_nested_attributes_for :items, allow_destroy: true
  has_many :comments, as: :commentable
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
end
