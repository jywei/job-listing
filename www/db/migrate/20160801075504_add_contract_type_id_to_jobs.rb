class AddContractTypeIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :contract_type_id, :integer
  end
end
