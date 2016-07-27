class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :status
      t.text :description
      t.text :requirement
      t.text :apply_instruction
      t.string :url
      t.string :email
      t.date :start_day
      t.integer :views_count,                default: 0
      t.integer :applied_count,              default: 0
      t.text :professional_skill
      t.string :salary_range
      t.string :year_salary_range
      t.boolean :is_published,               default: false

      t.timestamps null: false
    end
  end
end
