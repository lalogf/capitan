class AddPointsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :points, :integer
  end
end
