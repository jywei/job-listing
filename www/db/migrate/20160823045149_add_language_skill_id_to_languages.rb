class AddLanguageSkillIdToLanguages < ActiveRecord::Migration
  def change
    remove_column :languages, :name, :string
    add_column :languages, :language_skill_id, :integer
  end
end
