class AddUpdatedToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :updated_password, :boolean
  end

  def down
  	remove_column :accounts, :updated_password
  end
end
