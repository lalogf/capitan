class ChangeDniUsers < ActiveRecord::Migration
  def change
        change_column :users, :dni, :string, :null => true
  end
end
