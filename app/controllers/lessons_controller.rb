class LessonsController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end
  before_action :set_track
  before_action :set_course
  before_action :set_unit

  layout "admin"

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = @unit.lessons.order(:sequence)
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = @unit.lessons.find(params[:id])
  end

  # GET /lessons/new
  def new
    @lesson = @unit.lessons.new
  end

  # GET /lessons/1/edit
  def edit
    @lesson = @unit.lessons.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = @unit.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to [@track,@course,@unit,@lesson], notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      @lesson = @unit.lessons.find(params[:id])
      if @lesson.update(lesson_params)
        format.html { redirect_to [@track,@course,@unit,@lesson], notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = @unit.lessons.find(params[:id])
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to track_course_unit_lessons_url(@track,@course, @unit), notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :unit_id, :sequence, :points, :lesson_plan)
    end
end
