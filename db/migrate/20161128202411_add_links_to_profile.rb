class AddLinksToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :github, :string
    add_column :profiles, :linkedin, :string
    add_column :profiles, :portafolio, :string
  end
end
