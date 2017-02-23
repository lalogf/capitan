class AddOptionalToPages < ActiveRecord::Migration
  def change
    add_column :pages, :optional, :boolean
  end
end
