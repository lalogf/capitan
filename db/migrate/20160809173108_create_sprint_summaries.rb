class CreateSprintSummaries < ActiveRecord::Migration
  def change
    create_table :sprint_summaries do |t|
      t.belongs_to :user, index: true
      t.integer :sprint_id
      t.float :total_technical_skills
      t.float :total_soft_skills
      t.float :max_technical_skills
      t.float :max_soft_skills

      t.timestamps null: false
    end
  end
end
