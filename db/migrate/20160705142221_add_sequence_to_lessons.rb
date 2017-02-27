class AddSequenceToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :sequence, :integer, :default => 0
  end
end
