class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :featured_img
      t.string :content
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
