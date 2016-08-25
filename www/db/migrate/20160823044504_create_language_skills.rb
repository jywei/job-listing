class CreateLanguageSkills < ActiveRecord::Migration
  def change
    create_table :language_skills do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
