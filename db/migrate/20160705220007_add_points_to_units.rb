class AddPointsToUnits < ActiveRecord::Migration
  def change
    add_column :units, :points, :integer
  end
end
