class AddLevelToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :level, :integer
  end
end
