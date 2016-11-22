class Teacher::DashboardController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end

  layout "teacher"

  def class_stats
  end

  def students
  end

  def teacher_stats
  end

  def grades
    @branches = Branch.all
    @soft_skills = SoftSkill.all
  end

  def grades_filter
    status, message = "ok", "success"
    begin
      case params[:filter]
      when "group"
        result = Group.where(branch_id: params[:options][:branch_id]).pluck(:id, :name)
      when "sprint"
        result = Sprint.where(group_id: params[:options][:group_id]).pluck(:id,:name)
      when "lesson"
        result = Sprint.find(params[:options][:sprint_id]).lessons.pluck(:id,:title)
      when "page"
        result = SprintPage.
                 where("sprint_id = ? and pages.lesson_id = ?",params[:options][:sprint_id],params[:options][:lesson_id]).
                 where.not("pages.page_type": %w[material score]).
                 joins(:page).pluck("pages.id","concat(pages.title,' (',pages.page_type,')')")
      end
    rescue => error
      error.backtrace
      status = "fail"
      message = "No pudimos obtener el filtro solicitado"
    end
    render :json => { status: status, message: message, data: result }
  end

  def assistance
  end

  def sprints
  end

  def recomendations
  end
end
