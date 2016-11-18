class AddAudienceToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :audience, :integer
  end
end
