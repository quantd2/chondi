class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  has_many :votes, as: :votable
  has_many :upvoted_users, through: :votes, source: :user
end
