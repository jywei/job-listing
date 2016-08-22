class AddLanguageSkillsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :language_skills, :text
  end
end
