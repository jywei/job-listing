class CreateDjis < ActiveRecord::Migration
  def change
    create_table :djis do |t|
      t.integer :industry_id
      t.integer :resume_id

      t.timestamps null: false
    end
  end
end
