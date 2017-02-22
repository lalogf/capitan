class AddShowTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :show_title, :boolean, :default => true
  end
end
