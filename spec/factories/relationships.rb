FactoryBot.define do
  factory :relationship, class: Relationship do
    association :follower, factory: :user
    association :followed, factory: [:user, :orther_user]
  end
end
