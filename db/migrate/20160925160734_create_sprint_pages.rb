class CreateSprintPages < ActiveRecord::Migration
  def change
    create_table :sprint_pages do |t|
      t.references :sprint
      t.references :page
      t.integer :points

      t.timestamps null: false
    end
  end
end
