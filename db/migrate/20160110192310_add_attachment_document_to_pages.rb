class AddAttachmentDocumentToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :pages, :document
  end
end
