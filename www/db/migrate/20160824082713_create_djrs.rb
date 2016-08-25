class CreateDjrs < ActiveRecord::Migration
  def change
    create_table :djrs do |t|
      t.integer :category_id
      t.integer :resume_id

      t.timestamps null: false
    end
  end
end
