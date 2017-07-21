class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  has_reputation :votes, source: :user, aggregated_by: :sum
end
