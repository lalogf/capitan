class AddBirthDateToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :birth_date, :date
  end
end
