class ChangeProfileOtherActivitiesToText < ActiveRecord::Migration
  def change
    change_column :profiles, :other_tech_related_activities, :text
  end
end
