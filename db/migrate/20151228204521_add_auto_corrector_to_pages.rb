class AddAutoCorrectorToPages < ActiveRecord::Migration
  def change
    add_column :pages, :auto_corrector, :boolean, :default => false
  end
end
