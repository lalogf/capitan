class AddStatusToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :status, :boolean
  end
end
