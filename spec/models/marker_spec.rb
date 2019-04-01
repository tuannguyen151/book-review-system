RSpec.describe Marker, type: :model do
  subject {FactoryBot.create :marker}

  it {is_expected.to define_enum_for :status}
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :book}
    it {is_expected.to have_one(:activity).dependent :destroy}
  end
  describe "#create_activities" do
    let (:marker) {FactoryBot.create :marker}
    it "add activity to activities" do
      expect(marker.activity).to eq(Activity.last)
    end
  end
end
