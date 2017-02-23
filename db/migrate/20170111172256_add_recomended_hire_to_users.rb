class AddRecomendedHireToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recomended_as, :integer, default:0
    add_column :users, :hire, :boolean, default: false
  end
end
