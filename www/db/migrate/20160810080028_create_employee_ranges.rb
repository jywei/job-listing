class CreateEmployeeRanges < ActiveRecord::Migration
  def change
    create_table :employee_ranges do |t|
      t.string :range

      t.timestamps null: false
    end
  end
end
