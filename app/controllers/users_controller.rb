require 'wannabe_bool'

class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  layout "admin"

  # GET /users
  # GET /users.json
  def index
    @branches = Branch.all

    # An admin has to belong to a group for the below statement to work properly

    @branch_id = params[:branch_id] || current_user.group.branch_id
    @branch = Branch.find(@branch_id)

    @groups = @branch.groups

    @students = @branch.students
    @admins = @branch.admins
    @disables = @branch.disables
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @branch = @user.branch
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
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

  # DELETE /users/1
  # DELETE /users/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:code, :dni, :name, :lastname1, :lastname2,
      :email, :group_id, :district, :age,:facebook_username,:phone1,:phone2,:password,
      :avatar, :role)
    end
end
