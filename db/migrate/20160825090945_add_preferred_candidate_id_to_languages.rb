class AddPreferredCandidateIdToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :preferred_candidate_id, :integer
  end
end
