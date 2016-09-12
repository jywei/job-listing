class AddIsReadToCoverLetter < ActiveRecord::Migration
  def change
    add_column :cover_letters, :is_read, :boolean
  end
end
