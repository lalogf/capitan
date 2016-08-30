class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :page, index: true
      t.belongs_to :user, index: true
      t.string :link
      t.integer :points
      t.timestamps null: false
    end
  end
end
