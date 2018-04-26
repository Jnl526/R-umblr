class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email
      t.string :password
      t.string :img_url
      t.string :info
      t.string :statement 
    end
  end
end
