class ItemGroup < ApplicationRecord
  MIN_ITEM_NUM = 2
  MAX_ITEM_NUM = 5

  has_many :items
  has_many :users, through: :items

  accepts_nested_attributes_for :items, allow_destroy: true
  has_many :comments, as: :commentable

  validates :name, presence: true, length: { maximum: 50 }

  # , before_add: :validate_item_limit
  
  # def validate_item_limit item
  #   unless self.items.size.between? MIN_ITEM_NUM, MAX_ITEM_NUM
  #     errors.add(:items, message: 'bạn chỉ được tạo 2-5 sự lựa chọn')
  #     raise Exception.new 'bạn chỉ được tạo 2-5 sự lựa chọn'
  #   end
  # end
end
