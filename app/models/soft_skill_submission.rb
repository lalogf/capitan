# == Schema Information
#
# Table name: soft_skill_submissions
#
#  id            :integer          not null, primary key
#  soft_skill_id :integer
#  user_id       :integer
#  sprint_id     :integer
#  points        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SoftSkillSubmission < ActiveRecord::Base
  belongs_to :soft_skill
  belongs_to :user
  belongs_to :sprint

  scope :for_user, -> (user) { 
  		where(user_id: user.id).
  		joins(:soft_skill).
  		group(:name).
  		pluck_to_hash(:name,'sum(points) as points','sum(max_points) as max_points')
  }
end
