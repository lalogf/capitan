class CreateFamilyIncomes < ActiveRecord::Migration
  def change
    create_table :family_incomes do |t|
      t.references :branch, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
