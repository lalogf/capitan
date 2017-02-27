class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.references :branch, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
