class AddSalaryRangeIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :salary_range_id, :integer
  end
end
