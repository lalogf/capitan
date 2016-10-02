class AddSequenceToSprint < ActiveRecord::Migration
  def change
    add_column :sprints, :sequence, :integer
  end
end
