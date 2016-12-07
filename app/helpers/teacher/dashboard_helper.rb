module Teacher::DashboardHelper

  def select_points(sprint_page,page)
    return sprint_page.points.nil? ? page.points : sprint_page.points
  end

  def find_submission_points(user_id,submissions)
    submissions.select { |s| s[0] == user_id } != nil ? submissions.select { |s| s[0] == user_id }.first[1] : nil
  end

end
