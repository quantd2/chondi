class Poll < ApplicationRecord
  MIN_OPTION_NUM = 2
  MAX_OPTION_NUM = 5

  has_many :options
  has_many :users, through: :options

  accepts_nested_attributes_for :options, allow_destroy: true
  has_many :comments, as: :commentable

  validates :name, presence: true, length: { maximum: 50 }

  # , before_add: :validate_option_limit

  # def validate_option_limit option
  #   unless self.options.size.between? MIN_OPTION_NUM, MAX_OPTION_NUM
  #     errors.add(:options, message: 'bạn chỉ được tạo 2-5 sự lựa chọn')
  #     raise Exception.new 'bạn chỉ được tạo 2-5 sự lựa chọn'
  #   end
  # end
end
