class AddLifespanToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :student_lifespan, :text
  end
end
