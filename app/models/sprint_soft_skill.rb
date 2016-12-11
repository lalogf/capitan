# == Schema Information
#
# Table name: sprint_soft_skills
#
#  id            :integer          not null, primary key
#  sprint_id     :integer
#  soft_skill_id :integer
#  points        :decimal(11, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SprintSoftSkill < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :soft_skill

  scope :with_points, -> { where("sprint_soft_skills.points > ? or soft_skills.points > ?",0,0) }

end
