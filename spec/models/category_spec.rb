RSpec.describe Category, type: :model do
  subject {FactoryBot.create :category}

  context "associations" do
    it {is_expected.to have_many(:books).dependent :destroy}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most 100}
  end
end
