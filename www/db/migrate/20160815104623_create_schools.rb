class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :university_id
      t.date :start_day
      t.date :end_day
      t.integer :degree_level_id
      t.string :field_of_study
      t.string :grade
      t.integer :resume_id

      t.timestamps null: false
    end
  end
end
