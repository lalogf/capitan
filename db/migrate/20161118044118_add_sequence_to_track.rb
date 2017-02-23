class AddSequenceToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :sequence, :integer
  end
end
