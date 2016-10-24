class AddExtraFieldsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :reasons_to_enter, :string
    add_column :profiles, :how_you_find_out, :string
    add_column :profiles, :what_is_laboratoria, :string
  end
end
