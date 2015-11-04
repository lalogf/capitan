class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
    edit_user_registration_path(resource)
end

end