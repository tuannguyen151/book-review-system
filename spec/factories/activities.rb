FactoryBot.define do
  factory :activity, class: Activity do
    user
    association :activitable, factory: :marker
  end
end
