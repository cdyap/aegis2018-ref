class AddMinorsToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :minor2, :string
    add_column :accounts, :minor3, :string
    add_column :accounts, :minor4, :string
    add_column :accounts, :triple_major, :string
  end

  def down
  	remove_column :accounts, :minor2
  	remove_column :accounts, :minor3
  	remove_column :accounts, :minor4
  	remove_column :accounts, :triple_major
  end
end
