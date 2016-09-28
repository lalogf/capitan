class PagesController < ApplicationController

  layout "pages", only: [:show]
  layout "admin", except: [:show]

  before_action :set_track, except: [:saveAnswer,:saveQuestion, :saveAnswers]
  before_action :set_course, except: [:saveAnswer,:saveQuestion, :saveAnswers]
  before_action :set_unit, except: [:saveAnswer,:saveQuestion, :saveAnswers]
  before_action :set_lesson, except: [:saveAnswer,:saveQuestion, :saveAnswers]

  def index
    @pages = @lesson.pages.all
  end

  def show
    @page = @lesson.pages.find(params[:id])
    @previous_page = @lesson.pages.find_by_sequence(@page.sequence-1)
    @next_page = @lesson.pages.find_by_sequence(@page.sequence+1)
    @next_lesson = @lesson
    if @next_page == nil
      @next_lesson = Lesson.where("unit_id = ? and sequence = ?",@unit.id, @lesson.sequence+1).first
      if @next_lesson != nil
        @next_page = @next_lesson.pages.first
      end
    end
    @page.answers.find_or_create_by(page_id: @page.id,user_id: current_user.id)
    if @page.load_from_previous
      @page.initial_state = @previous_page.answers.where(user_id: current_user.id).first.result
    end
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
        format.html { redirect_to [@track,@course,@unit,@lesson], notice: 'Page was successfully created.' }
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
        format.html { redirect_to [@track,@course,@unit,@lesson], notice: 'Page was successfully updated.' }
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
      format.html { redirect_to [@track,@course,@unit,@lesson], notice: 'Page was successfully destroyed.' }
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
