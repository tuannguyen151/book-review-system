User.create! email: "user@gmail.com",
  password: "123123"
User.create! email: "admin@gmail.com",
  password: "123123", admin: true
user_first = User.first
user_first.create_user_profile name: "Admin TEST", gender: "male",
  birthday: "1997-01-01", address: "Viet Nam", phone: "0966666666"
Category.create! name: "website"
Category.first.books.create! title: "Ruby programing",
  description: "Description", publish_date: "2019-01-01", number_pages: 100,
    price: 101010, author: "TSN"
user_first.markers.create! book: Book.first, status: "favorite"
user_first.follow User.last
user_first.likes.create! activity: Activity.first
user_first.comments.create! commentable: Activity.first, content: "commented"
user_first.reviews.create! book: Book.first, content: "Awesome", rate: 5
