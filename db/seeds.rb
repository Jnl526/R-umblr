require 'faker'

# User.create(first_name: "Bob", last_name: "Tester", birthday: "08/16/1987", email: "test@email.com", password: "test123", img_url: "", info: "yes", statement: "yes")

# Post.create(title: "Name", featured_img: "none", content: "first,hello", user_id: 1)

# Tag.create(tag_name: "first")
# Tag.create(name: "hello")

# PostTag.create(post_id: 1, tag_id: 1)
# PostTag.create(post_id: 1, tag_id: 2)

10.times do |i|
    User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,birthday: Faker::Date.birthday(25, 41), email:"name#{i+1}@domain.com", password: "test123", img_url: Faker::Placeholdit.image, info: Faker::VForVendetta.speech, statement: Faker::WorldOfWarcraft.quote)
end

10.times do |e|
    	Post.create(title: Faker::Dune.title, featured_img: Faker::Placeholdit.image, content: Faker::Lorem.paragraphs(1), user_id: (rand(9) + 1))
    end 

10.times do |i|
        Tag.create(name: Faker::Lorem.word)
    end

10.times do |i|
        PostTag.create(post_id: (rand(9) + 1), tag_id: (rand(9) + 1))
    end