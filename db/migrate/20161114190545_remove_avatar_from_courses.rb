class RemoveAvatarFromCourses < ActiveRecord::Migration
  def change
    remove_attachment :courses, :avatar
    remove_attachment :courses, :background_image
  end
end
