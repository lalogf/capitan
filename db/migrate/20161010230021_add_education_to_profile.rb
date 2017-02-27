class AddEducationToProfile < ActiveRecord::Migration
  def change
    add_reference :profiles, :education, index: true, foreign_key: true
  end
end
