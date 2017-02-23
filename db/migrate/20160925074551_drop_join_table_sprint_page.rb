class DropJoinTableSprintPage < ActiveRecord::Migration
  def change
    drop_join_table :sprints, :pages
  end
end
