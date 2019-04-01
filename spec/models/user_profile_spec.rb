RSpec.describe UserProfile, type: :model do
  subject {FactoryBot.create :user_profile}

  it {is_expected.to define_enum_for :gender}
  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most 100}
    it {is_expected.to validate_uniqueness_of :name}
    it {is_expected.to validate_length_of(:address).is_at_most 255}
    it {is_expected.to allow_value("").for :address}
    it {is_expected.to validate_length_of(:phone).is_at_most 255}
    it {is_expected.to allow_value("0966666666").for :phone}
    it {is_expected.to allow_value("").for :phone}
    describe "#min_birthday" do
      let (:user_profile_failure_min) do
        FactoryBot.build :user_profile, :failure_min
      end
      it "failure" do
        expect(user_profile_failure_min.save).to eq false
      end
    end
    describe "#min_birthday" do
      let (:user_profile_failure_max) do
        FactoryBot.build :user_profile, :failure_max
      end
      it "failure" do
        expect(user_profile_failure_max.save).to eq false
      end
    end
  end
end
