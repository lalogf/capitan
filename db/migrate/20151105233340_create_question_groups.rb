class CreateQuestionGroups < ActiveRecord::Migration
  def change
    create_table :question_groups do |t|
      t.references :page, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.integer :sequence

      t.timestamps null: false
    end
  end
end
