class AddInstructionsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :instructions, :string
  end
end
