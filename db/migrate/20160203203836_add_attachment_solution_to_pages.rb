class AddAttachmentSolutionToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :solution
    end
  end

  def self.down
    remove_attachment :pages, :solution
  end
end
