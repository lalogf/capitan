class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
    return course_list_url
end

end