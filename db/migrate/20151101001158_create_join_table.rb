class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :pages, :videos do |t|
      # t.index [:page_id, :video_id]
      # t.index [:video_id, :page_id]
    end
  end
end
