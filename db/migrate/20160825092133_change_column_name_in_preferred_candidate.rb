class ChangeColumnNameInPreferredCandidate < ActiveRecord::Migration
  def change
    rename_column :preferred_candidates, :job_category_id, :category_id
  end
end
