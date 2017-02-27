class AddAcceptingLatestUserToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :accepting_latest_users, :boolean, default: false
  end
end
