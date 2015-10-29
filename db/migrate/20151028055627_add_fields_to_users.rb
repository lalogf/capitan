class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :null => false
    add_column :users, :code, :string, :null => false
  end
end
