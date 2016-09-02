class AddCountingsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :jobs_count, :integer
    add_column :companies, :views_count, :integer
  end
end
