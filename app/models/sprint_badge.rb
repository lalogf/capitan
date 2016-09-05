# == Schema Information
#
# Table name: sprint_badges
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  badge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SprintBadge < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :badge

  has_and_belongs_to_many :users

  def badge_name
  	self.badge.name
  end
end
