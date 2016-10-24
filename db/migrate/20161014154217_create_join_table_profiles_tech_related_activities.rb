class CreateJoinTableProfilesTechRelatedActivities < ActiveRecord::Migration
  def change
    create_join_table :profiles, :tech_related_activities do |t|
      # t.index [:profile_id, :tech_related_activity_id]
      # t.index [:tech_related_activity_id, :profile_id]
    end
  end
end
