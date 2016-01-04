class AddSequenceToUnits < ActiveRecord::Migration
  def change
    add_column :units, :sequence, :integer, :default => 0
  end
end
