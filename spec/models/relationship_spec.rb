RSpec.describe Relationship, type: :model do
  subject {FactoryBot.create :relationship}

  context "associations" do
    it {is_expected.to belong_to(:followed).class_name User.name}
    it {is_expected.to belong_to(:follower).class_name User.name}
    it {is_expected.to have_one(:activity).dependent :destroy}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :follower_id}
    it {is_expected.to validate_presence_of :followed_id}
  end
  describe "#create_activities" do
    let (:relationship) {FactoryBot.create :relationship}
    it "add activity to activities" do
      expect(relationship.activity).to eq(Activity.last)
    end
  end
end
