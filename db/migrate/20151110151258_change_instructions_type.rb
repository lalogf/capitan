class ChangeInstructionsType < ActiveRecord::Migration
  def change
    change_column :pages, :instructions, :text
  end
end
