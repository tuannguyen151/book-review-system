FactoryBot.define do
  factory :marker, class: Marker do
    user
    book
    status {"favorite"}
  end
end
