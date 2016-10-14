class AddSemestersLeftToProfile < ActiveRecord::Migration
  def change
    add_reference :profiles, :semesters_left, index: true, foreign_key: true
  end
end
