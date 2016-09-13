class AddCoverLettersCountToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :cover_letters_count, :integer, default: 0
  end
end
