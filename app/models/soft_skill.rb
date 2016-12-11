# == Schema Information
#
# Table name: soft_skills
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  max_points  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text(65535)
#  stype       :integer
#

class SoftSkill < ActiveRecord::Base

	has_many :soft_skills_submissions
	enum stype: [:communication,:teamwork,:adaptability,:attendance]

	validates :name, presence: true

end
