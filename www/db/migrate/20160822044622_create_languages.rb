class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.integer :proficiency_id
      t.integer :resume_id

      t.timestamps null: false
    end
  end
end
