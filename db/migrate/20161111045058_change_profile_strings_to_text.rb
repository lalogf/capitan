class ChangeProfileStringsToText < ActiveRecord::Migration
  def change
    change_column :profiles, :biography, :text
    change_column :profiles, :reasons_to_enter, :text
    change_column :profiles, :how_you_find_out, :text
    change_column :profiles, :what_is_laboratoria, :text
  end
end
