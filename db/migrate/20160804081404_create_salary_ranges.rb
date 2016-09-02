class CreateSalaryRanges < ActiveRecord::Migration
  def change
    create_table :salary_ranges do |t|
      t.string :range
      t.integer :jobs_count, default: 0

      t.timestamps null: false
    end
  end
end
