class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
  students_tracks_home_url
end

end
