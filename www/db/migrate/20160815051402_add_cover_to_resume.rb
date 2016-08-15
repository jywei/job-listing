class AddCoverToResume < ActiveRecord::Migration
  def change
    add_attachment :resumes, :cover
  end
end
