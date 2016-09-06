class CreateLanguageCodes < ActiveRecord::Migration
  def change
    create_table :language_codes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
