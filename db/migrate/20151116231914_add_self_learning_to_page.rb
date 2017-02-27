class AddSelfLearningToPage < ActiveRecord::Migration
  def change
    add_column :pages, :selfLearning, :boolean, :default => false
  end
end
