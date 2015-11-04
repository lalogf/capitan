class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :title
      t.string :description
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
