user_first = User.create! email: "user@gmail.com", password: "123123",
  confirmed_at: Time.now
admin = User.create! email: "admin@gmail.com", password: "123123", admin: true,
  confirmed_at: Time.now
User.create! email: "failure@gmail.com", password: "123123"
user_first.create_user_profile name: "NV User", gender: "female",
  birthday: "1997-01-01", address: "Viet Nam", phone: "0966666666"
admin.create_user_profile name: "NV Admin", gender: "male",
  birthday: "1997-01-01", address: "Viet Nam", phone: "0966666665"
category = Category.create! name: "website"
category.books.create! title: "Ruby programing",
  description: "Description", publish_date: "2019-01-01", number_pages: 100,
    price: 101010, author: "TSN"
user_first.markers.create! book: Book.first, status: "favorite"
user_first.following << admin
user_first.likes.create! activity: Activity.first
user_first.comments.create! commentable: Activity.first, content: "commented"
user_first.reviews.create! book: Book.first, content: "Awesome", rate: 5

30.times do
  category.books.create! title: Faker::Book.unique.title,
    description: "Description", publish_date: "2019-01-01", number_pages: 100,
      price: 10101, author: Faker::Book.author
  user = User.create! email: Faker::Internet.unique.free_email,
    password: "123123", confirmed_at: Time.now
  user.create_user_profile name: Faker::Name.unique.name, gender: "male",
    birthday: Faker::Date.birthday(18, 30), address: "Viet Nam",
      phone: Faker::PhoneNumber.unique.subscriber_number(10)
end

100.times do
  user = User.find_by id: rand(1..30)
  book = Book.find_by id: rand(1..30)
  user.reviews.create book: book, content: "test reviews",
    rate: rand(1..5)
end
