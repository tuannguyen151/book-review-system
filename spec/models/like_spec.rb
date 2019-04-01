RSpec.describe Like, type: :model do
  subject {FactoryBot.create :like}

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :activity}
  end
end
