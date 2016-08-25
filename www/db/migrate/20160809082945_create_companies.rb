class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :tagline
      t.string :phone
      t.string :email
      t.text   :about
      t.text   :story
      t.text   :welfare
      t.text   :demand
      t.text   :idea
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :ios
      t.string :android
      t.boolean :is_hiring

      t.timestamps null: false
    end
  end
end
