class CreateCoverLetters < ActiveRecord::Migration
  def change
    create_table :cover_letters do |t|
      t.integer :resume_id
      t.integer :job_id
      t.string :description

      t.timestamps null: false
    end
  end
end
