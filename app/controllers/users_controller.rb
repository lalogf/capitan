# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string(255)      default("")
#  encrypted_password          :string(255)      default(""), not null
#  reset_password_token        :string(255)
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :string(255)
#  last_sign_in_ip             :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  provider                    :string(255)
#  uid                         :string(255)
#  admin                       :boolean          default(FALSE)
#  dni                         :string(255)
#  code                        :string(255)
#  name                        :string(255)      not null
#  lastname1                   :string(255)      not null
#  lastname2                   :string(255)
#  age                         :integer
#  district                    :string(255)
#  facebook_username           :string(255)
#  phone1                      :string(255)
#  phone2                      :string(255)
#  branch_id                   :integer
#  disable                     :boolean          default(FALSE)
#  my_draft_comments_count     :integer          default(0)
#  my_published_comments_count :integer          default(0)
#  my_comments_count           :integer          default(0)
#  draft_comcoms_count         :integer          default(0)
#  published_comcoms_count     :integer          default(0)
#  deleted_comcoms_count       :integer          default(0)
#  spam_comcoms_count          :integer          default(0)
#

require 'wannabe_bool'

class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout "admin"

  # GET /users
  # GET /users.json
  def index
    @branches = Branch.all
    @branch_id = params[:branch_id] != nil ? params[:branch_id] : current_user.branch_id
    
    @students = User.students(@branch_id)
    @admins = User.admins(@branch_id)
    @disables = User.disables(@branch_id)
  end

  # GET /users/1
  # GET /users/1.json
  def show
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
      :email, :branch_id, :district, :age,:facebook_username,:phone1,:phone2,:admin,:password, :password_confirmation)
    end
end
