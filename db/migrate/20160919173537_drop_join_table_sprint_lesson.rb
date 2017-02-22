class DropJoinTableSprintLesson < ActiveRecord::Migration
  def change
    drop_join_table :sprints, :lessons
  end
end
