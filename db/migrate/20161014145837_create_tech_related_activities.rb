class CreateTechRelatedActivities < ActiveRecord::Migration
  def change
    create_table :tech_related_activities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
