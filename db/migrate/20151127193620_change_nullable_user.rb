class ChangeNullableUser < ActiveRecord::Migration
  def change
    change_column :users, :age, :integer, :null => true
    change_column :users, :lastname2, :string, :null => true
    change_column :users, :district, :string, :null => true
  end
end
