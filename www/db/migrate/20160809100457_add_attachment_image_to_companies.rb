class AddAttachmentImageToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :image
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :companies, :image
    remove_attachment :companies, :cover
  end
end
