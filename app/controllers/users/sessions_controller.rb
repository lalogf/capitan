class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
  new_groups = [15, 16]
  ce_groups = [24]

  resource.applicant? ? selection_url :
  resource.employer? ? employer_dashboard_coders_url :
  new_groups.include?(resource.group_id)  ? show_track_url(2) :
  ce_groups.include?(resource.group_id) ? show_track_url(7) : show_track_url(1)
end

end
