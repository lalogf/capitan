class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    show_track_url(1)
  end

  def after_sign_up_path_for(resource)
    show_track_url(1)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
      :email,
      :signup_branch,
      profile_attributes:
        [:name,:dni,:birth_date,:district,:phone1,:facebook_link,:education,:major,
         :school,:semesters_left,:reasons_school_not_done,:job_status,:work_for,
         :job_title,:job_payroll,:job_type,:job_salary,:family_income,:relatives,
         :childs,:tech_savy,:tech_related_activities,:other_tech_related_activities,
         :computer_at_home,:internet_access,:smartphone,:computer_use,:biography,
         :spot])
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:dni, :code, :name, :lastname1, :lastname2,
               :group_id, :district, :age, :facebook_username,
               :email, :phone1, :phone2, :password, :current_password)
    end
  end

end
