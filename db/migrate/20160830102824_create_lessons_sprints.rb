class CreateLessonsSprints < ActiveRecord::Migration
  def change
    create_table :lessons_sprints, id: false do |t|
      t.references :lesson, foreign_key: true
      t.references :sprint, foreign_key: true
    end

    # Add a compound index for both of the columns as MySQL only
    # uses one index per table during the lookup (From Rails documentaion)
    add_index :lessons_sprints, [:lesson_id, :sprint_id]
  end
end
