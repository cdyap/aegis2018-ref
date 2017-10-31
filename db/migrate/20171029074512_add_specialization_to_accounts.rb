class AddSpecializationToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :specialization, :string
  end

  def down
  	remove_column :accounts, :specialization
  end
end
