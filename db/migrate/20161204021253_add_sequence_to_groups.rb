class AddSequenceToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :sequence, :integer, default: 0
  end
end
