class CreateRelatedExperiences < ActiveRecord::Migration
  def change
    create_table :related_experiences do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
