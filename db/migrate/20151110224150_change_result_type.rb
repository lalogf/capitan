class ChangeResultType < ActiveRecord::Migration
  def change
    change_column :answers, :result, :text
  end
end
