class CreateSprintBadges < ActiveRecord::Migration
  def change
    create_table :sprint_badges do |t|
      t.references :sprint, index: true, foreign_key: true
      t.references :badge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
