class RemoveAdminFromUsers < ActiveRecord::Migration
  def change
    # The third and fourth arguments are to make sure
    # that the migration is reversible. Otherwise ActiveRecord
    #  will raise an exception saying remove_column is only
    # reversible if given a type. For more, see http://edgeguides.rubyonrails.org/active_record_migrations.html#using-the-change-method
    remove_column :users, :admin, :boolean, default: false
  end
end
