require "faker"

FactoryBot.define do
  factory :user, class: User do
    sequence(:email){Faker::Internet.email}
    password {"123123"}
    trait :admin do
      email {"admin@gmail.com"}
      admin {true}
      confirmed_at {Time.now}
    end
    trait :orther_user do
      sequence(:email){Faker::Internet.email}
      password {"123123"}
    end
    trait :user_devise do
      email {"user@gmail.com"}
      confirmed_at {Time.now}
    end
    trait :unconfirm do
      email {"user1@gmail.com"}
    end
  end
end
