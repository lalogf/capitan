class SprintPage < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :page

  scope :with_points, -> { where("sprint_pages.points > ? or pages.points > ?",0,0).where("pages.page_type not in (?)",%w[material score]) }

  def self.total_points
    SprintPage.with_points.
    joins(:sprint, :page).
    group(:page_type).
    pluck(:page_type, 'round(sum(coalesce(sprint_pages.points,pages.points)))')
  end

  def self.student_points user
    SprintPage.with_points.
    joins(:sprint, {page: :submissions}).
    where('submissions.user_id = ?', user.id).
    references(:submissions).group(:page_type).
    pluck(:page_type, 'round(sum(submissions.points))')
  end

end
