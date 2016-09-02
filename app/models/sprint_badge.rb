class SprintBadge < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :badge

  validates :sprint_id, presence: true
  validates :badge_id, presence: true
end
