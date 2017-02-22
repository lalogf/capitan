class ChangeDescriptionTracksToText < ActiveRecord::Migration
  def change
    change_column :tracks, :description, :text
  end
end
