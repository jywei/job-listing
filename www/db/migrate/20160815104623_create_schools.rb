class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.date :start_day
      t.date :end_day
      t.integer :degree_level_id, index: true
      t.string :field_of_study
      t.string :grade

      t.timestamps null: false
    end
  end
end
