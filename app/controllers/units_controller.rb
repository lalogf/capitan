class UnitsController < ApplicationController
  
  before_action :set_course 
  
  layout "admin"

  # GET /units
  # GET /units.json
  def index
    @units = @course.units.order(:sequence)
  end

  # GET /units/1
  # GET /units/1.json
  def show
    @unit = @course.units.find(params[:id])
  end

  # GET /units/new
  def new
    @unit = @course.units.new
  end

  # GET /units/1/edit
  def edit
    @unit = @course.units.find(params[:id])
  end

  # POST /units
  # POST /units.json
  def create
    @unit = @course.units.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to [@course,@unit], notice: 'Unit was successfully created.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      @unit = @course.units.find(params[:id])
      if @unit.update(unit_params)
        format.html { redirect_to [@course,@unit], notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit = @course.units.find(params[:id])
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to course_units_url(@course), notice: 'Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:title, :description, :course_id, :sequence)
    end
end
