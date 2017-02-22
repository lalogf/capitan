class RemoveTechRelatedActivitiesFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :tech_related_activities, :integer
  end
end
