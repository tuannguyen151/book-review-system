FactoryBot.define do
  factory :review, class: Review do
    user
    book
    rate {5}
    content {"Awesome"}
  end
end
