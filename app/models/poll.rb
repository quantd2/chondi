class Poll < ApplicationRecord
  MIN_OPTION_NUM = 2
  MAX_OPTION_NUM = 5

  has_many :options
  has_many :users, through: :options

  accepts_nested_attributes_for :options, allow_destroy: true
  has_many :comments, as: :commentable

  validates :name, presence: true, length: { maximum: 50 }

  def normalized_votes_for(option)
    votes_summary == 0 ? 0 : (option.reputation_for(:votes).to_f / votes_summary) * 100
  end

  def votes_summary
    options.inject(0) {|summary, option| summary + option.reputation_for(:votes)}
  end

  # , before_add: :validate_option_limit

  # def validate_option_limit option
  #   unless self.options.size.between? MIN_OPTION_NUM, MAX_OPTION_NUM
  #     errors.add(:options, message: 'bạn chỉ được tạo 2-5 sự lựa chọn')
  #     raise Exception.new 'bạn chỉ được tạo 2-5 sự lựa chọn'
  #   end
  # end
end
