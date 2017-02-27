class AddStatusToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :status, :boolean
  end
end
