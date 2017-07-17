class Vote < ApplicationRecord
  belongs_to :user

  belongs_to :votable, polymorphic: true, counter_cache: true
  validates :user_id, uniqueness: { scope: :votable }
end
