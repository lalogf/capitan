class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dni, :string, :null => false
    add_column :users, :code, :string, :null => false
    add_column :users, :name, :string, :null => false
    add_column :users, :lastname1, :string, :null => false
    add_column :users, :lastname2, :string, :null => false
    add_column :users, :age, :integer, :null => false
    add_column :users, :district, :string, :null => false
    add_column :users, :facebook_username, :string
    add_column :users, :phone1, :string, :null => false
    add_column :users, :phone2, :string
  end
end
