class RenameSoftSkillTypeColumn < ActiveRecord::Migration
  def change
    rename_column :soft_skills, :type, :stype
  end
end
