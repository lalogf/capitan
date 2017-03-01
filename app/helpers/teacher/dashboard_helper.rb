module Teacher::DashboardHelper

  def select_points(sprint_page,page)
    return sprint_page.points.nil? ? page.points : sprint_page.points
  end

  def find_submission_points(page_id,user_id,submissions)
    s = submissions.select { |s| s[0] == page_id and s[1] == user_id }
    return !s.empty? ? submissions.select { |s| s[0] == page_id and s[1]== user_id }.first[2] : nil
  end

  def find_soft_skills_submissions_points(user_id,soft_skill_id,submissions)
    s = submissions.select { |s| s[0] == user_id and s[1] == soft_skill_id }
    return s != nil && !s.empty? ? s.first[2] : nil
  end

end
