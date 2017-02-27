class AddColumnsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :description, :string
    add_column :tracks, :duration, :integer
  end
end
