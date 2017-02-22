class ChangeSemesterLeftProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :semesters_left
  end
end
