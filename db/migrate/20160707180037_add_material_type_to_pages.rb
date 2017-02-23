class AddMaterialTypeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :material_type, :string
  end
end
