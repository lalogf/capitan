class AddAddressToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :address, :string
  end
end
