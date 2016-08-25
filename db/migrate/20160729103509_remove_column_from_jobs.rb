class RemoveColumnFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :url, :string
    remove_column :jobs, :email, :string
    remove_column :jobs, :salary_range, :string
    remove_column :jobs, :year_salary_range, :string
  end
end
