class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
  students_dashboard_tracks_url
end

end
