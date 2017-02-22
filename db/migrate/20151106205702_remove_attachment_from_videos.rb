class RemoveAttachmentFromVideos < ActiveRecord::Migration
  def change
    remove_attachment :videos, :content
  end
end
