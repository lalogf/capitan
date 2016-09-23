# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  user_id    :integer
#  link       :string(255)
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ActiveRecord::Base

  belongs_to :user
  belongs_to :page

  def self.avg_classroom_points group_id, sprint_id
    Submission.joins(:user).
               joins(:page => :sprints).
               where("sprints.id = ?", sprint_id).
               where("users.disable = 0").
               where("users.group_id = ?",group_id).
               group("users.id").
               pluck("round(sum(submissions.points))").
               reduce [ 0.0, 0 ] do |(s, c), e| [ s + e, c + 1 ] end.reduce(&:/).round
  end

  def self.avg_all_classroom_points group_id
    Submission.joins(:user).
               joins(:page => :sprints).
               where("users.disable = 0").
               where("users.group_id = ?",group_id).
               group("users.id").
               pluck("round(sum(submissions.points))").
               reduce [ 0.0, 0 ] do |(s, c), e| [ s + e, c + 1 ] end.reduce(&:/).round
  end
end
