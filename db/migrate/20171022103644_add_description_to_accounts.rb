class AddDescriptionToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :description, :string
  end

  def down
  	remove_column :accounts, :description
  end
end
