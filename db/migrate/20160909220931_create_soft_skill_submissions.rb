class CreateSoftSkillSubmissions < ActiveRecord::Migration
  def change
    create_table :soft_skill_submissions do |t|
      t.references :soft_skill, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :sprint, index: true, foreign_key: true
      t.integer :points

      t.timestamps null: false
    end
  end
end
