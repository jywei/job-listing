class CreateEmploymentStatuses < ActiveRecord::Migration
  def change
    create_table :employment_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
