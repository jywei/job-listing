class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.date :start_day
      t.date :end_day
      t.references :degree_level, index: true, foreign_key: true
      t.string :field_of_study
      t.string :grade

      t.timestamps null: false
    end
  end
end
