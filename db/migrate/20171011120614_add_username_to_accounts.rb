class AddUsernameToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :is_graduating, :boolean
  end
end
