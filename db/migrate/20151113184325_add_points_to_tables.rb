class AddPointsToTables < ActiveRecord::Migration
  def change
    add_column :answers, :points, :integer
    add_column :pages, :points, :integer
    add_column :question_groups, :points, :integer
  end
end
