class CreatePreferredCandidates < ActiveRecord::Migration
  def change
    create_table :preferred_candidates do |t|
      t.integer :job_id
      t.integer :location_id
      t.integer :country_id
      t.integer :language_id
      t.integer :contract_type_id
      t.integer :job_category_id
      t.integer :career_level_id
      t.integer :degree_level_id
      t.integer :related_experience_id

      t.timestamps null: false
    end
  end
end
