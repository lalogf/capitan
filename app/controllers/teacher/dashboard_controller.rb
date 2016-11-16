class Teacher::DashboardController < ApplicationController

  before_action :require_admin

  layout "teacher"

  def class_stats
  end

  def students
  end

  def teacher_stats
  end

  def grades
  end

  def assistance
  end

  def sprints
  end

  def recomendations
  end
end
