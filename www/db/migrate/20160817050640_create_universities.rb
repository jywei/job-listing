class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.integer :country_id

      t.timestamps null: false
    end
  end
end
