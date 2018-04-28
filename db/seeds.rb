User.create(first_name: "Bob", last_name: "Tester", birthday: "08/16/1987", email: "test@email.com", password: "test123", img_url: "", info: "yes", statement: "yes")

Post.create(title: "Name", featured_img: "none", content: "first,hello", user_id: 1)

Tag.create(tag_name: "first")
Tag.create(tag_name: "hello")

PostTag.create(post_id: 1, tag_id: 1)
PostTag.create(post_id: 1, tag_id: 2)