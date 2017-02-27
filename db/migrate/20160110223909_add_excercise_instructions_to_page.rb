class AddExcerciseInstructionsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :excercise_instructions, :text
  end
end
