class DropSprintSummaryTable < ActiveRecord::Migration
  def change
    drop_table :sprint_summaries
  end
end
