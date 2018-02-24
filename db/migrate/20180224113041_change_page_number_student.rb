class ChangePageNumberStudent < ActiveRecord::Migration
  def up
    change_table :students do |t|
      t.change :page_number, :string
    end
  end
 
  def down
    change_table :students do |t|
      t.change :page_number, :integer
    end
  end
end
