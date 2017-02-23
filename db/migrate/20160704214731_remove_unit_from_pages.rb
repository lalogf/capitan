class RemoveUnitFromPages < ActiveRecord::Migration
  def change
    remove_reference :pages, :unit, index: true, foreign_key: true
  end
end
