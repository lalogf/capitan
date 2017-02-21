class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
  new_groups = [15, 16]
  ec_groups = [24, 25]
  resource.applicant? ? selection_url :
  resource.employer? ? employer_dashboard_coders_url :
  new_groups.include?(resource.group_id)  ? show_track_url(2) :
  # ec_groups.include?(resource.group_id) ? show_track_url(7) : show_track_url(1)
  resource.group_id = 24 ? show_track_url(7) :
  resource.group_id = 25 ? show_track_url(6) : show_track_url(1)
end

end
