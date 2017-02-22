class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :page, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :result

      t.timestamps null: false
    end
  end
end
