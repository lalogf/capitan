class ChangeCourseColumnEnrollment < ActiveRecord::Migration
  def change
    Enrollment.destroy_all
    remove_reference :enrollments, :course, index: true,foreign_key: true
    add_reference :enrollments, :track, index: true,foreign_key: true
  end
end
