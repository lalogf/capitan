class AddAttachmentBackgroundImageToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :background_image
    end
  end

  def self.down
    remove_attachment :courses, :background_image
  end
end
