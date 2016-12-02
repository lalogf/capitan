class AddDescriptionToSoftSkill < ActiveRecord::Migration
  def change
    add_column :soft_skills, :description, :string
  end
end
