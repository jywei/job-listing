class CreateDegreeLevels < ActiveRecord::Migration
  def change
    create_table :degree_levels do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
