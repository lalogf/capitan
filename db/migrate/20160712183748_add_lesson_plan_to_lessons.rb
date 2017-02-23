class AddLessonPlanToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :lesson_plan, :string
  end
end
