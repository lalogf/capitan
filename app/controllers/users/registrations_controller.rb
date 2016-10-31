class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters


  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      MandrillDeviseMailer.new_registration(resource).deliver
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def update_resource(user, params)
    user.update_without_password(params)
  end

  def after_update_path_for(user)
    show_track_url(1)
  end

  def after_sign_up_path_for(user)
    admission_success_url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
      :email,
      :signup_branch,
      profile_attributes:
        [:name,:dni,:birth_date,:district_id,:phone1,:facebook_link,:education_id,:major,
         :school,:semesters_left_id,:reasons_school_not_done,:job_status,:work_for,
         :job_title,:job_payroll,:job_type,:job_salary_id,:family_income_id,:relatives,
         :childs, :tech_savy, {:tech_related_activity_ids => []}, :other_tech_related_activities,
         :computer_at_home,:internet_access,:smartphone,:computer_use,:biography,
         :spot_id])
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(
      :email,
      :signup_branch,
      profile_attributes:
        [:name,:dni,:birth_date,:district_id,:phone1,:facebook_link,:education_id,:major,
         :school,:semesters_left_id,:reasons_school_not_done,:job_status,:work_for,
         :job_title,:job_payroll,:job_type,:job_salary_id,:family_income_id,:relatives,
         :childs, :tech_savy, {:tech_related_activity_ids => []}, :other_tech_related_activities,
         :computer_at_home,:internet_access,:smartphone,:computer_use,:biography,
         :spot_id])
    end
  end

end
