class AddJobsCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :jobs_count, :integer
  end
end
