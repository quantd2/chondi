class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  validates_uniqueness_of :user_id, scope: [:reportable_type, :reportable_id]

end
