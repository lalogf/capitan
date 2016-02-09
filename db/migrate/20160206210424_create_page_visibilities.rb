class CreatePageVisibilities < ActiveRecord::Migration
  def change
    create_table :page_visibilities do |t|
      t.references :page, index: true, foreign_key: true
      t.references :branch, index: true, foreign_key: true
      t.boolean :status

      t.timestamps null: false
    end
  end
end
