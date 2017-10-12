class AddLegacyToAccounts < ActiveRecord::Migration
  def up
  end

  def down
  	remove_column :accounts, :legacy_password_hash
  end

end
