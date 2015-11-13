class ChangePhone1User < ActiveRecord::Migration
  def change
    change_column :users, :phone1, :string, :null => true
  end
end
