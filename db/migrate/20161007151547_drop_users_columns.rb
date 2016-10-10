class DropUsersColumns < ActiveRecord::Migration
  def change
    remove_column :users, :dni
    remove_column :users, :name
    remove_column :users, :lastname1
    remove_column :users, :lastname2
    remove_column :users, :age
    remove_column :users, :district
    remove_column :users, :facebook_username
    remove_column :users, :phone1
    remove_column :users, :phone2
    remove_column :users, :biography
  end
end
