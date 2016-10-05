class AddForeignKeySprintPages < ActiveRecord::Migration
  def change
    add_foreign_key :sprint_pages, :sprints
    add_foreign_key :sprint_pages, :pages
  end
end
