class Comment < ApplicationRecord
  include Common

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  alias_attribute :author, :user
  validates :body, presence: true

  has_reputation :votes, source: :user, aggregated_by: :sum

  paginates_per 10

  # def normalized_name
  #   self.class.to_s.tableize.singularize
  # end
  #
  # def normalized_id
  #   normalized_name + "_" + self.id.to_s
  # end
end
