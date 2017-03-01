class Admin::PagesController < ApplicationController

  layout "admin", except: [:show]

  before_action :set_track, except: [:saveAnswer,:saveQuestion, :saveAnswers]
  before_action :set_course, except: [:saveAnswer,:saveQuestion, :saveAnswers]
  before_action :set_unit, except: [:saveAnswer,:saveQuestion, :saveAnswers]
  before_action :set_lesson, except: [:saveAnswer,:saveQuestion, :saveAnswers]

  before_action only: [:show] do
    check_allowed_roles(current_user, ["student","assistant","teacher","admin"])
  end
  before_action except: [:show] do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end

  def index
    @pages = @lesson.pages.all
  end

  def show
    @page = @lesson.pages.find(params[:id])
    @page.answers.find_or_create_by(page_id: @page.id,user_id: current_user.id)
    if @page.load_from_previous
      @page.initial_state = @previous_page.answers.where(user_id: current_user.id).first.result
    end
    if @page.page_type == "score"
      topic = {"prework" => "Quiz ", "exercise" => "Ejercicio", "solution" => "Solución", "retrospective" => "Retrospectiva", "codereview" => "Code Review"}
      @scoreable_pages = @lesson.pages.with_points(current_user.group_id).
                         pluck_to_hash("pages.id as id","pages.title as title","pages.page_type as page_type",
                                       "coalesce(sprint_pages.points,pages.points) as points")
      @pages_points = Array.new
      @scoreable_pages.each { |page|
        if page["points"] > 0
          @pages_points.push({
            student_points: Submission.where(user_id: current_user.id,page_id: page["id"]).first.try(:points).to_f,
            average_points: Submission.joins(:user).where("submissions.page_id = ? and users.group_id = ?",page["id"],current_user.group_id).pluck("avg(points)").first.try(:to_f),
            page_points: page["points"],
            page_title: "#{topic[page["page_type"]]}: #{page["title"]}",
            page_type: page["page_type"]
          })
        end
      }

      @total_student_points = @pages_points.map { |p| p[:student_points] }.reduce(:+)
      @total_page_points = @pages_points.map { |p| p[:page_points] }.reduce(:+)
      @total_average_points = @pages_points.map { |p| p[:average_points] }.reduce(:+)
    end
    render layout: 'pages'
  end

  def new
    @branches = Branch.all
    @page = @lesson.pages.new
    @page.questions.build
  end

  def edit
    @branches = Branch.all
    @page = @lesson.pages.find(params[:id])
  end

  def create

    # We need @branches defined here in case a validation error occurs
    # because when we render the `new` action,
    # _exercise_fields partial needs `@branches`
    # If we don't define @branches, here then @branches will be nil
    # in `_exercise_fields`

    @branches = Branch.all
    @page = @lesson.pages.new(page_params)
    respond_to do |format|
      if @page.save
        format.html { redirect_to [:admin,@track,@course,@unit,@lesson], notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @page = @lesson.pages.find(params[:id])
      if @page.update(page_params)
        format.html { redirect_to [:admin,@track,@course,@unit,@lesson], notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = @lesson.pages.find(params[:id])
    @page.destroy
    respond_to do |format|
      format.html { redirect_to [:admin,@track,@course,@unit,@lesson], notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def saveAnswer
    answer = Answer.find_by_page_id_and_user_id(params[:page_id],params[:user_id])
    page = Page.find(params[:page_id])
    if answer != nil
      answer.result = params[:answer] if params[:answer] != nil
      answer.points = page.points if page.auto_corrector
      answer.save
      render :json => { :status => :ok, :message => "success" }
    end
  end

  def saveAnswers
    status = "ok"
    message = "success"
    begin
      if params[:answer_ids] != nil
        for i in 0...params[:answer_ids].length
          answer = Answer.find(params[:answer_ids][i])
          if answer != nil
            answer.points = params[:answer_values][i]
            answer.save
          end
        end
      end
    rescue
      status = "fail"
      message = "We could not save the answers"
    end
    render :json => { :status => status, :message => message }
  end

  def saveQuestion
    answer = Answer.find_by_page_id_and_user_id(params[:page_id],current_user.id)
    page = Page.find(params[:page_id])
    if answer != nil

      questionGroup = page.question_groups.find_by_sequence(params[:sequence].to_i+1)
      if answer.result == nil
        result = "#{questionGroup != nil ? questionGroup.id : "MAX"};#{params[:question_group_id]}|#{params[:option_id]}"
      else
        parts = answer.result.split(";")
        result = "#{questionGroup != nil ? questionGroup.id : "MAX"};#{parts[1,parts.length].join(";")};#{params[:question_group_id]}|#{params[:option_id]}"
      end
      answer.result = result
      answer.points = (answer.points != nil ? answer.points : 0) + (Option.find(params[:option_id]).correct? ? page.question_points : 0)
      answer.save
      render :json => { :status => :ok, :questionGroupId => questionGroup != nil ? questionGroup.id : nil, :sequence => questionGroup != nil ? params[:sequence].to_i+1 : "MAX" }
    end
  end

  private
    def set_track
      @track = Track.find(params[:track_id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_unit
      @unit = @course.units.find(params[:unit_id])
    end

    def set_lesson
      @lesson = @unit.lessons.find(params[:lesson_id])
    end

    def page_params
      params.require(:page).permit(:title, :page_type,:material_type,:sequence, :lesson_id, :html,
      :initial_state, :slide_url,:quiz_url, :solution, :videotip, :load_from_previous,
      :auto_corrector, :grade, :points, :question_points, :selfLearning,
      :success_message, :instructions, :document, :excercise_instructions,
      :solution_file, :video_solution, :show_solution, :solution_visibility,
      :show_title, :video_url, :code,
      question_groups_attributes: [ :id,:sequence, :question_id, :points, :_destroy])
    end
end
