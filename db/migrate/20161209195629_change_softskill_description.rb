class ChangeSoftskillDescription < ActiveRecord::Migration
  def change
    change_column :soft_skills, :description, :text
  end
end
