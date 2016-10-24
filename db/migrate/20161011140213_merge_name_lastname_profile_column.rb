class MergeNameLastnameProfileColumn < ActiveRecord::Migration
  def change
    Profile.find_each do |profile|
      profile.name = "#{profile.name} #{profile.lastname}"
      profile.save!
    end
    remove_column :profiles, :lastname
  end
end
