class ItemGroup < ApplicationRecord
  MIN_ITEM_NUM = 2
  MAX_ITEM_NUM = 5

  has_many :items
  # , before_add: :validate_item_limit
  accepts_nested_attributes_for :items, allow_destroy: true
  has_many :comments, as: :commentable
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }

  # def validate_item_limit item
  #   unless self.items.size.between? MIN_ITEM_NUM, MAX_ITEM_NUM
  #     errors.add(:items, message: 'bạn chỉ được tạo 2-5 sự lựa chọn')
  #     raise Exception.new 'bạn chỉ được tạo 2-5 sự lựa chọn'
  #   end
  # end
end
