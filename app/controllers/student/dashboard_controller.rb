class Student::DashboardController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["student","assistant","teacher","admin"])
  end

  def home
  end

  def performance
  end

  def tracks
    @user = current_user
    @sprint_badges = @user.sprint_badges.group_by(&:badge).map { |key,value| [key,value.size] }

    @maximum_points = SprintPage.total_points(@user.group_id).map { |e| e[1] }.reduce(&:+)
    @student_points = SprintPage.student_points(@user).map { |e| e[1] }.reduce(&:+)
    @badge_points = @user.sprint_badges.joins(:badge).pluck('badges.points').reduce(&:+)
    @soft_skills_points = SoftSkillSubmission.for_user(@user)

    @student_technical_points = { points: (@student_points != nil ? @student_points : 0) + (@badge_points != nil ? @badge_points : 0),
                                  max: @maximum_points }
    @student_hse_points = { points: @soft_skills_points.map { |e| e["points"]}.reduce(&:+),
                            max: @soft_skills_points.map { |e| e["max_points"]}.reduce(&:+) }

    @tracks = Track.all.order(:sequence)
  end

  def resources
  end

  def surveys
    @tracks = Track.all.order(:sequence)
    @branchs = Branch.all
    @groups = Group.all
    @teachers = ["Lead Teacher","Lead Teacher","Teacher Assistant 1","Teacher Assistant 2", "Teacher Assistant 3"]
    @jedis = ["Ale", "Andrea Lamas","Arabela","Elizabeth","Lalo","Mafe","Malu","Meche","Michelle","Papu"]
    @temas = ['Introducción al desarrollo web', 'HTML/ HTML5 y JavaScript en el navegador','Manejo de comandos básicos de git en la terminal','Pruebas unitarias','Git/ Resolución de conflictos/ Branching model','DOM 101']
  end

end
