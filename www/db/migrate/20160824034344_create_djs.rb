class CreateDjs < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.integer :salary
      t.integer :resume_id

      t.timestamps null: false
    end
  end
end
