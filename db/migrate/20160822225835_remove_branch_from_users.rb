class RemoveBranchFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :branch, index: true, foreign_key: true
  end
end
