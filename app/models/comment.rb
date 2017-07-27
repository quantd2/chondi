class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :user
  alias_attribute :author, :user
  validates :body, presence: true
  has_reputation :votes, source: :user, aggregated_by: :sum

  paginates_per 5
end
