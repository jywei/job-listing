class AddAddressToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :address1, :string
    add_column :companies, :address2, :string
  end
end
