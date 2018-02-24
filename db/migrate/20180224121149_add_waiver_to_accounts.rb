class AddWaiverToAccounts < ActiveRecord::Migration
  def up
      add_column :accounts, :yearbook_waiver, :boolean, default: false
  end
 
  def down
      remove_column :accounts, :yearbook_waiver
  end
end
