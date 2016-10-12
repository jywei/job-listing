class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.text :text
      t.string :author
      t.attachment :cover

      t.timestamps null: false
    end
  end
end
