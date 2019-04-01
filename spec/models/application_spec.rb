RSpec.describe ApplicationRecord do
  let(:user) {FactoryBot.create :report}
  describe ".human_enum_name" do
    it "return i18n enum" do
      expect(Marker.human_enum_name :status, :favorite).to eq("Favorite")
    end
  end
end
