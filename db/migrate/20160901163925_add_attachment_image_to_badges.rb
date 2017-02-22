class AddAttachmentImageToBadges < ActiveRecord::Migration
  def self.up
    change_table :badges do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :badges, :image
  end
end
