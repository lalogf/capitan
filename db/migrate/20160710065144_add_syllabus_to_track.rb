class AddSyllabusToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :syllabus, :string
  end
end
