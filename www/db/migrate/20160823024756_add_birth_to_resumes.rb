class AddBirthToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :birth, :date
  end
end
