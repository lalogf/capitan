class Users::SessionsController < Devise::SessionsController

def after_sign_in_path_for(resource)
    course = Course.find_by(code: "001")
    return course_unit_page_path(course.id,course.units.first,course.units.first.pages.first)
end

end