class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  belongs_to :user
  belongs_to :item_group

  mount_uploader :image, ImageUploader

  has_reputation :votes, source: :user, aggregated_by: :sum
end
