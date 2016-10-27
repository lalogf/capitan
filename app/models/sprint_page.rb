# == Schema Information
#
# Table name: sprint_pages
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  page_id    :integer
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SprintPage < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :page

  scope :with_points, -> { where("sprint_pages.points > ? or pages.points > ?",0,0).where("pages.page_type not in (?)",%w[material score]) }

  def self.total_points group_id
    SprintPage.with_points.
    joins({:sprint => :group}, :page).
    where("groups.id = ?",group_id).
    group(:page_type).
    pluck(:page_type, 'round(sum(coalesce(sprint_pages.points,pages.points)))')
  end

  def self.student_points user
    SprintPage.with_points.
    joins({sprint: :group}, {page: :submissions}).
    where('submissions.user_id = ? and groups.id = ?', user.id, user.group_id).
    references(:submissions).group(:page_type).
    pluck(:page_type, 'round(sum(submissions.points))')
  end

  def self.lessons_for_group group
    SprintPage.
    joins(:sprint,{:page => :lesson}).
    order("sprints.name").
    group("lessons.id").
    distinct.
    pluck_to_hash("sprints.id as sprint_id","sprints.name as sprint_name",
                  "sprints.description as sprint_description",
                  "lessons.unit_id as unit_id","lessons.id as lesson_id","lessons.title as title",
                  "pages.id as page_id",
                  "round(sum(coalesce(sprint_pages.points, pages.points))) as points")
  end

end
