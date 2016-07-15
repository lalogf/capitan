class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :page, index: true
      t.belongs_to :question, index: true
      t.text :answer
      t.integer :user_id
      t.integer :reviewer_id

      t.timestamps null: false
    end
  end
end
