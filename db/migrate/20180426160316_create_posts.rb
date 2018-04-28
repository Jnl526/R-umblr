class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :featured_img
      t.string :content
      t.integer :user_id

      t.date null: false
    end
  end
end
