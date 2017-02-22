class ChangeColumnPointsSubmissions < ActiveRecord::Migration
  def change
  	change_column :submissions, :points, :decimal, precision: 5, scale: 2
  end
end
