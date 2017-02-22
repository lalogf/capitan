class AddGradeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :grade, :integer, :default => 0
  end
end
