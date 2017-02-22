class AddVideoSolutionToPage < ActiveRecord::Migration
  def change
    add_column :pages, :video_solution, :string
  end
end
