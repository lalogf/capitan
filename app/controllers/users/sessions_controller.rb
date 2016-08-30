class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
  show_track_url(1)
end

end
