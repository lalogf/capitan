class Employer::DashboardController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["employer","admin"])
  end

  layout 'employer'

  def coders
    branch = Branch.find(1);
    @students = branch.students
  end

  def profile
    @user = User.find(params[:user_id])
    @sprint_badges = @user.sprint_badges.group_by(&:badge).map { |key,value| [key,value.size] }

    @maximum_points = SprintPage.total_points(@user.group_id).map { |e| e[1] }.reduce(&:+)
    @student_points = SprintPage.student_points(@user).map { |e| e[1] }.reduce(&:+)
    @badge_points = @user.sprint_badges.joins(:badge).pluck('badges.points').reduce(&:+)
    @soft_skills_points = SoftSkillSubmission.for_user(@user)
    @avg_students_points = Submission.avg_all_classroom_points(current_user.group_id)

    @student_technical_points = { points: @student_points + + (@badge_points != nil ? @badge_points : 0),
                                  max: @maximum_points }
    @student_hse_points = { points: @soft_skills_points.map { |e| e["points"]}.reduce(&:+),
                            max: @soft_skills_points.map { |e| e["max_points"]}.reduce(&:+) }
  end

  private

  def sum_points data_arr, page_type
    data_arr.map {|e| e[page_type]}.reduce(&:+)
  end

end
