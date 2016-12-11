class AddTypeToSoftSkill < ActiveRecord::Migration
  def change
    add_column :soft_skills, :stype, :integer
  end
end
