require 'wannabe_bool'

class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end

  layout "admin"

  def index
    @branches = Branch.all

    #FIX_QUICKLY: An admin has to belong to a group
    #for the below statement to work properly
    @branch_id = params[:branch_id] || current_user.branch.id
    @branch = Branch.find(@branch_id)

    @groups = @branch.groups

    @students = @branch.students
    @admins = @branch.admins
    @disables = @branch.disables
  end

  def show
    @branch = @user.branch
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_user_status
    status = "ok"
    message = "success"
    begin
      if (params[:status] != nil && params[:user_id] != nil)
        u = User.find(params[:user_id])
        if u != nil
          u.disable = params[:status].to_b
          u.save
        else
          raise "User not found"
        end
      else
        raise "Parameter invalid"
      end
    rescue => exception
      puts exception.backtrace
      status = "fail"
      message = "We could not change user status"
    end
    render :json => { :status => status, :message => message }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:code, :email, :group_id,:password, :avatar, :role, sprint_badge_ids: [],
      profile_attributes: [:name, :lastname, :github, :linkedin, :portafolio], :recomended_as, :hire)
    end
end
