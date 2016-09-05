class AddEmploymentStatusIdToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :employment_status_id, :integer
  end
end
