class AddCoursePlanToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_plan, :string
  end
end
