class RemoveShowSolutionFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :show_solution, :boolean
  end
end
