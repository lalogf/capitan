class DropVideos < ActiveRecord::Migration
  def up
    drop_table :videos
    drop_table :pages_videos
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
