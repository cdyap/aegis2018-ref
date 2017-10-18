class AddTypeToGroupslot < ActiveRecord::Migration
  def up
    add_column :groupslots, :group_type, :string
  end
  def down
    remove_column :groupslots, :group_type
  end
end
