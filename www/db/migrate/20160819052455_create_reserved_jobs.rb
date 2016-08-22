class CreateReservedJobs < ActiveRecord::Migration
  def change
    create_table :reserved_jobs do |t|
      t.integer :tracking_user_id
      t.integer :favorite_job_id

      t.timestamps null: false
    end
  end
end
