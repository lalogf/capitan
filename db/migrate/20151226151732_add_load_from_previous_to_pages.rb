class AddLoadFromPreviousToPages < ActiveRecord::Migration
  def change
    add_column :pages, :load_from_previous, :boolean, :deafult => false
  end
end
