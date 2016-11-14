class AddAttachmentIconToTracks < ActiveRecord::Migration
  def self.up
    change_table :tracks do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :tracks, :icon
  end
end
