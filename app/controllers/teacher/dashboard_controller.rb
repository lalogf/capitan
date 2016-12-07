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

  def grades_filters
      @branches = Branch.all
      @soft_skills = SoftSkill.all
      render 'grades_filter'
  end

  def grades_input
    if request.post?
      for i in 0..params[:input][:users].size
        submission = Submission.find_or_initialize_by(user_id: params[:input][:users][i],page_id:params[:input][:page_id])
        submission.points = params[:input][:grades][i]
        submission.save
      end
      params[:page_id] = params[:input][:page_id]
      params[:sprint_id] = params[:input][:sprint_id]
      params[:lesson_id] = params[:input][:lesson_id]
      params[:group_id] = params[:input][:group_id]
    end

    @sprint = Sprint.find(params[:sprint_id])
    @lesson = Lesson.find(params[:lesson_id])
    @page   = Page.find(params[:page_id])
    @group  = Group.find(params[:group_id])
    @sprintPage = SprintPage.where(sprint_id:params[:sprint_id],page_id:params[:page_id]).first
    @users  = User.includes(:profile).where(group_id: params[:group_id], role: 1, disable:false)
    @submissions = Submission.where(page_id: params[:page_id],user_id: @users.map { |u| u.id }).map { |s| [s.user_id,s.points]}
    render 'grades_input'

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
                 where("sprint_pages.points > ? or pages.points > ?",0,0).
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
