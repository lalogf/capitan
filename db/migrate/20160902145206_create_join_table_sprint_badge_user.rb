class CreateJoinTableSprintBadgeUser < ActiveRecord::Migration
  def change
    create_join_table :sprint_badges, :users do |t|
      # t.index [:sprint_badge_id, :user_id]
      # t.index [:user_id, :sprint_badge_id]
    end
  end
end
