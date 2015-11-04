class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.references :unit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
