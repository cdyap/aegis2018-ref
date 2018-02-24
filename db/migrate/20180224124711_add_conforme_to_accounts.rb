class AddConformeToAccounts < ActiveRecord::Migration
  def up
      add_column :accounts, :conforme, :string, default: nil
  end
 
  def down
      remove_column :accounts, :conforme
  end
end
