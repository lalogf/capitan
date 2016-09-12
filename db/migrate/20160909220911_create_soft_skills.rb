class CreateSoftSkills < ActiveRecord::Migration
  def change
    create_table :soft_skills do |t|
      t.string :name
      t.integer :max_points

      t.timestamps null: false
    end
  end
end
