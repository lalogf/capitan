class Employer::DashboardController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["employer","admin"])
  end

  layout 'employer'

  def coders
    if current_user.branch.id == 1
      @students = User.includes(:profile).where(role: 1, disable: 0, group_id: [5,21])
      @student_technical_points = Submission.students_technical_points(5) +
                                  Submission.students_technical_points(21)
      @student_hse_points = SoftSkillSubmission.students_technical_points(5) +
                            SoftSkillSubmission.students_technical_points(21)

      @badges_points = User.where(group_id:5).joins(:sprint_badges => :badge).group(:id).pluck(:id,"sum(points)") +
                       User.where(group_id:21).joins(:sprint_badges => :badge).group(:id).pluck(:id,"sum(points)")
    elsif current_user.branch.id == 3
      @students = User.includes(:profile).where(role: 1, disable: 0, group_id: [8,22])
      @student_technical_points = Submission.students_technical_points(8) +
                                  Submission.students_technical_points(22)
      @student_hse_points = SoftSkillSubmission.students_technical_points(8) +
                            SoftSkillSubmission.students_technical_points(22)

      @badges_points = User.where(group_id:8).joins(:sprint_badges => :badge).group(:id).pluck(:id,"sum(points)") +
                       User.where(group_id:22).joins(:sprint_badges => :badge).group(:id).pluck(:id,"sum(points)")
    end

    @students_ordered = @students.map { |e| [e,(@student_technical_points.select { |s| s[0] == e.id }.first != nil ? (@student_technical_points.select { |s| s[0] == e.id }.first)[3] : 0) +
                                               (@student_hse_points.select { |s| s[0] == e.id}.first != nil ? (@student_hse_points.select { |s| s[0] == e.id}.first)[3] : 0) +
                                               (@badges_points.select{ |s| s[0] == e.id}.first != nil ? (@badges_points.select{ |s| s[0] == e.id}.first)[1] : 0) ]}.sort_by  { |k| k[1]*-1 }
  end

  def profile
    @user = User.find(params[:user_id])
    @sprint_badges = @user.sprint_badges.group_by(&:badge).map { |key,value| [key,value.size] }

    @maximum_points = SprintPage.total_points(@user.group_id).map { |e| e[1] }.reduce(&:+)
    @student_points = SprintPage.student_points(@user).map { |e| e[1] }.reduce(&:+)
    @badge_points = @user.sprint_badges.joins(:badge).pluck('badges.points').reduce(&:+)
    @soft_skills_points = SoftSkillSubmission.for_user(@user)
    @avg_soft_skills_points = SoftSkillSubmission.avg_classroom_points(@user)
    @avg_students_points = Submission.avg_all_classroom_points(@user.group_id)

    @student_technical_points = { points: @student_points + (@badge_points != nil ? @badge_points : 0),
                                  max: @maximum_points }
    @student_hse_points = { points: @soft_skills_points.map { |e| e["points"]}.reduce(&:+),
                            max: @soft_skills_points.map { |e| e["max_points"]}.reduce(&:+) }

    @sprints = @user.group.sprints.joins(:pages).where("pages.points > 0 or sprint_pages.points > 0").order(:sequence).distinct
    @sprint_points = Array.new
    @sprints.each do |sprint|
      @sprint_points << {
        name: sprint.name,
        description: sprint.description,
        max: sprint.total_points.map { |e| e[1] }.reduce(&:+),
        points: sprint.student_points(@user).map { |e| e[1] }.reduce(&:+),
        average: Submission.avg_classroom_points(@user.group_id,sprint.id)
      }
    end
  end

  private

  def sum_points data_arr, page_type
    data_arr.map {|e| e[page_type]}.reduce(&:+)
  end

end
