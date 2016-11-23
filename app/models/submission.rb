# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  user_id    :integer
#  link       :string(255)
#  points     :decimal(5, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ActiveRecord::Base

  belongs_to :user
  belongs_to :page

  def self.avg_classroom_points group_id, sprint_id
    Submission.joins(:user).
               joins(:page => :sprints).
               where("(sprint_pages.points > 0 or pages.points > 0) and pages.page_type not in ('material','score')").
               where("sprints.id = ?", sprint_id).
               where("users.disable = 0").
               where("users.group_id = ?",group_id).
               group("users.id").
               pluck("round(sum(submissions.points))").
               reduce [ 0.0, 0 ] do |(s, c), e| [ s + e, c + 1 ] end.reduce(&:/).round
  end

  def self.avg_all_classroom_points group_id
    Submission.joins(:user).
               joins(:page => {:sprints => :group}).
               where("(sprint_pages.points > 0 or pages.points > 0) and pages.page_type not in ('material','score')").
               where("users.disable = 0").
               where("users.group_id = ?",group_id).
               where("groups.id = ?",group_id).
               group("users.id").
               pluck("round(sum(submissions.points))").
               reduce [ 0.0, 0 ] do |(s, c), e| [ s + e, c + 1 ] end.reduce(&:/).round
  end

  def self.students_technical_points group_id
    Submission.joins(:user => :profile).
    where("users.group_id = ? and users.role = 1 and users.disable = 0",group_id).
    group("users.id","users.code","profiles.name").
    order("submissions.points desc").
    pluck("users.id","users.code","profiles.name","CAST(sum(points) as UNSIGNED)")
  end
end
