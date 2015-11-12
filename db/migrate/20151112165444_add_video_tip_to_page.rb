class AddVideoTipToPage < ActiveRecord::Migration
  def change
    add_column :pages, :videotip, :string
  end
end
