class AddSequenceToPage < ActiveRecord::Migration
  def change
    add_column :pages, :sequence, :integer
  end
end
