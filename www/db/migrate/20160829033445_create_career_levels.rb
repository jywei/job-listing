class CreateCareerLevels < ActiveRecord::Migration
  def change
    create_table :career_levels do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
