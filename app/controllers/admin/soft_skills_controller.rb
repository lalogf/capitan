class Admin::SoftSkillsController < ApplicationController

  before_action :set_soft_skill, only: [:show, :edit, :update, :destroy]
  before_action do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end

  layout "admin"

  # GET /soft_skills
  # GET /soft_skills.json
  def index
    @soft_skills = SoftSkill.all.order(:stype)
  end

  # GET /soft_skills/1
  # GET /soft_skills/1.json
  def show
  end

  # GET /soft_skills/new
  def new
    @soft_skill = SoftSkill.new
  end

  # GET /soft_skills/1/edit
  def edit
  end

  # POST /soft_skills
  # POST /soft_skills.json
  def create
    @soft_skill = SoftSkill.new(soft_skill_params)

    respond_to do |format|
      if @soft_skill.save
        format.html { redirect_to admin_soft_skills_path, notice: 'Soft skill was successfully created.' }
        format.json { render :show, status: :created, location: @soft_skill }
      else
        format.html { render :new }
        format.json { render json: @soft_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /soft_skills/1
  # PATCH/PUT /soft_skills/1.json
  def update
    respond_to do |format|
      if @soft_skill.update(soft_skill_params)
        format.html { redirect_to admin_soft_skills_path, notice: 'Soft skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @soft_skill }
      else
        format.html { render :edit }
        format.json { render json: @soft_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soft_skills/1
  # DELETE /soft_skills/1.json
  def destroy
    @soft_skill.destroy
    respond_to do |format|
      format.html { redirect_to admin_soft_skills_url, notice: 'Soft skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_soft_skill
      @soft_skill = SoftSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def soft_skill_params
      params.require(:soft_skill).permit(:name, :max_points, :description, :stype)
    end
end
