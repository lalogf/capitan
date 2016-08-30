class AddQuizUrlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :quiz_url, :string
  end
end
