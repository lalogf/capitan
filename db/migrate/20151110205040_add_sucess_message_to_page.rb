class AddSucessMessageToPage < ActiveRecord::Migration
  def change
    add_column :pages, :success_message, :string
  end
end
