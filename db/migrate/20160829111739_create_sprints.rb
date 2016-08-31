class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string :name
      t.text :description
      t.references :group, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
