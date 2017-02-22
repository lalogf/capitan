class ChangeRoleToStudents < ActiveRecord::Migration
  def change
    User.where(role:0).update_all(role:1)
  end
end
