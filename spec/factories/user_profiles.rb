require "faker"

FactoryBot.define do
  factory :user_profile, class: UserProfile do
    user
    name {Faker::Name.name}
    gender {"male"}
    birthday {"1997-01-01"}
    address {"Viet Nam"}
    phone {"0966666666"}
    trait :failure_min do
      birthday {"1000-01-01"}
    end
    trait :failure_max do
      birthday {"3000-01-01"}
    end
  end
end
