FactoryBot.define do
  factory :comment, class: Comment do
    user
    content {"Nice"}
    association :commentable, factory: :activity
    trait :for_review do
      association :commentable, factory: :review
    end
  end
end
