class AddPointsToTables < ActiveRecord::Migration
  def change
    add_column :answers, :points, :integer
    add_column :pages, :points, :integer
    add_column :pages, :question_points, :integer
  end
end
