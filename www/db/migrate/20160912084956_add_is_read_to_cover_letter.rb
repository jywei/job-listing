class AddIsReadToCoverLetter < ActiveRecord::Migration
  def change
    add_column :cover_letters, :is_read, :boolean, default: false
  end
end
