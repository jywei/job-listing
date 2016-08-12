class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.references :location, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true 

      t.timestamps null: false
    end
  end
end
