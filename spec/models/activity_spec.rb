RSpec.describe Activity, type: :model do
   subject {FactoryBot.create :activity}

  context "associations" do
    it {is_expected.to belong_to :activitable}
    it {is_expected.to belong_to :user}
    it {is_expected.to have_many(:comments).dependent :destroy}
    it {is_expected.to have_many(:likes).dependent :destroy}
  end
end
