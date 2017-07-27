class Poll < ApplicationRecord
  MIN_OPTION_NUM = 2
  MAX_OPTION_NUM = 5

  has_many :options
  has_many :users, through: :options
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }

  scope :desc, -> { order(created_at: :desc) }
  scope :hot, -> { order(vote_count: :desc) }

  paginates_per 10

  def normalized_votes_for(option)
    votes_summary == 0 ? 0 : (option.reputation_for(:votes).to_f / votes_summary) * 100
  end

  def votes_summary
    # a = self.options.includes(:votes)
    options.inject(0) {|summary, option| summary + option.reputation_for(:votes).to_i}
  end

  # , before_add: :validate_option_limit

  # def validate_option_limit option
  #   unless self.options.size.between? MIN_OPTION_NUM, MAX_OPTION_NUM
  #     errors.add(:options, message: 'bạn chỉ được tạo 2-5 sự lựa chọn')
  #     raise Exception.new 'bạn chỉ được tạo 2-5 sự lựa chọn'
  #   end
  # end
end
