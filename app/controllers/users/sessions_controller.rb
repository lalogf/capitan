class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
    return courses_url
end

end