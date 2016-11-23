class CoursesController < ApplicationController

  before_action :set_track
  before_action :set_course, only: [:show, :edit, :update, :destroy, :show_details]

  before_action only: [:show_details] do
    check_allowed_roles(current_user, ["student","assistant","teacher","admin"])
  end
  before_action except: [:show_details] do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end

  layout "admin", except: [:show_details]

  def index
    @courses = @track.courses.all
  end

  def show
     @course = @track.courses.find(params[:id])
  end

  def show_details
    #@sprints = current_user.group.sprints.joins(:pages).order(:sequence).distinct.pluck_to_hash(:id,:name,:description)
    #@lessons = SprintPage.lessons_for_group current_user.group
    @week_start = 1
  end

  def new
    @course = @track.courses.new
  end

  def edit
    @course = @track.courses.find(params[:id])
  end

  def create
    @course = @track.courses.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to [@track,@course], notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @course = @track.courses.find(params[:id])
      if @course.update(course_params)
        format.html { redirect_to [@track,@course], notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = @track.courses.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def set_track
      @track = Track.find(params[:track_id])
    end

    def course_params
      params.require(:course).permit(:name,:description,:avatar,:color,:background_image,:code, :points, :course_plan)
    end
end
