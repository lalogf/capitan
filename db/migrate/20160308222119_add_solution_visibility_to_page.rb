class AddSolutionVisibilityToPage < ActiveRecord::Migration
  def change
    add_column :pages, :solution_visibility, :string
  end
end
