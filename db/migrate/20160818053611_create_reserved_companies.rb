class CreateReservedCompanies < ActiveRecord::Migration
  def change
    create_table :reserved_companies do |t|
      t.integer :following_user_id
      t.integer :favorite_company_id

      t.timestamps null: false
    end
  end
end
