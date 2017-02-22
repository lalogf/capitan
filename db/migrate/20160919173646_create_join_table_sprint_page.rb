class CreateJoinTableSprintPage < ActiveRecord::Migration
  def change
    create_join_table :sprints, :pages do |t|
      # t.index [:sprint_id, :page_id]
      # t.index [:page_id, :sprint_id]
    end
  end
end
