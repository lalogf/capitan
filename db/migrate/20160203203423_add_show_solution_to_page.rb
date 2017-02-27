class AddShowSolutionToPage < ActiveRecord::Migration
  def change
    add_column :pages, :show_solution, :boolean
  end
end
