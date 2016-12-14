module Teacher::DashboardHelper

  def select_points(sprint_page,page)
    return sprint_page.points.nil? ? page.points : sprint_page.points
  end

  def find_submission_points(user_id,submissions)
    s = submissions.select { |s| s[0] == user_id }
    return s != nil ? submissions.select { |s| s[0] == user_id }.first[1] : nil
  end

  def find_soft_skills_submissions_points(user_id,soft_skill_id,submissions)
    s = submissions.select { |s| s[0] == user_id and s[1] == soft_skill_id }
    return s != nil ? s.first[2] : nil
  end

end
