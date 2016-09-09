class CreateReservedResumes < ActiveRecord::Migration
  def change
    create_table :reserved_resumes do |t|
      t.integer :tracking_company_id
      t.integer :favorite_resume_id

      t.timestamps null: false
    end
  end
end
