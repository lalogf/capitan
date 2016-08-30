class AddDurationToUnit < ActiveRecord::Migration
  def change
    add_column :units, :duration, :integer
  end
end
