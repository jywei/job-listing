class AddEmployeeRangeIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :employee_range_id, :integer
  end
end
