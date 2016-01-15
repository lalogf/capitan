class AddSlideUrlToPage < ActiveRecord::Migration
  def change
    add_column :pages, :slide_url, :string
  end
end
