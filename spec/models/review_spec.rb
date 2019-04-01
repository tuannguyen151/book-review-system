RSpec.describe Review, type: :model do
  subject {FactoryBot.create :review}

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :book}
    it {is_expected.to have_many(:comments).dependent :destroy}
  end
end
