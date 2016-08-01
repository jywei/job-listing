class CreateContractTypes < ActiveRecord::Migration
  def change
    create_table :contract_types do |t|
      t.string :name
      t.integer :jobs_count, default: 0

      t.timestamps null: false
    end
  end
end
