class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :job_title
      t.string :company_name
      t.date :start_day
      t.date :end_day
      t.integer :country_id
      t.integer :industry_id
      t.integer :contract_type_id
      t.string :activities
      t.integer :resume_id

      t.timestamps null: false
    end
  end
end
