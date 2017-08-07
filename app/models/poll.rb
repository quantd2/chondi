class Poll < ApplicationRecord
  include Common
  # MIN_OPTION_NUM = 2
  # MAX_OPTION_NUM = 5
  has_many :options, dependent: :destroy
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :name, presence: true, length: { maximum: 100 }

  scope :desc, -> { order(created_at: :desc) }
  scope :hot, -> { order(vote_count: :desc) }

  after_touch :refresh_vote_count

  paginates_per 10

  def normalized_votes_for(option)
    votes_summary == 0 ? 0 : (option.reputation_for(:votes).to_f / votes_summary) * 100
  end

  def votes_summary
    options.inject(0) {|summary, option| summary + option.reputation_for(:votes).to_i}
  end

  def refresh_vote_count
    update(vote_count: votes_summary)
  end

  def self.text_search(query)
    if query.present?
      rank = <<-RANK
      ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("name @@ :q", q: "%#{query}%").order("#{rank} desc")
    else
      self.all
    end
  end

end
