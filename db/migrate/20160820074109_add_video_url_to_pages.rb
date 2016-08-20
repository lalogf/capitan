class AddVideoUrlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :video_url, :string
  end
end
