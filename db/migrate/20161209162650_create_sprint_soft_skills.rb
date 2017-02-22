class CreateSprintSoftSkills < ActiveRecord::Migration
  def change
    create_table :sprint_soft_skills do |t|
      t.references :sprint
      t.references :soft_skill
      t.decimal :points, precision: 11, scale: 2
      t.timestamps null: false
    end
  end
end
