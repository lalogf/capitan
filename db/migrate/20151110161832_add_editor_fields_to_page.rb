class AddEditorFieldsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :initial_state, :text
    add_column :pages, :solution, :text
  end
end
