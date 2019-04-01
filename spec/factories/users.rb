require "faker"

FactoryBot.define do
  factory :user, class: User do
    sequence(:email){Faker::Internet.email}
    password {"123123"}
    trait :admin do
      admin {true}
    end
    trait :orther_user do
      sequence(:email){Faker::Internet.email}
      password {"123123"}
    end
  end
end
