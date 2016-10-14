class AddSpotToProfile < ActiveRecord::Migration
  def change
    add_reference :profiles, :spot, index: true, foreign_key: true
  end
end
