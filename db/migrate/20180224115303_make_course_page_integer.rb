class MakeCoursePageInteger < ActiveRecord::Migration
  def up
    change_table :course_pages do |t|
      t.change :page_number, :string
    end
  end
 
  def down
    change_table :course_pages do |t|
      t.change :page_number, :integer
    end
  end
end
