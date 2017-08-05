class Comment < ApplicationRecord
  include Common

  belongs_to :commentable, polymorphic: true, touch: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  belongs_to :user

  alias_attribute :author, :user
  validates :body, presence: true

  has_reputation :votes, source: :user, aggregated_by: :sum

  paginates_per 10

end
