RSpec.describe Book, type: :model do
  subject {FactoryBot.create :book}

  context "associations" do
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many(:markers).dependent :destroy}
    it {is_expected.to have_many(:reviews).dependent :destroy}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_length_of(:title).is_at_most 255}
    it {is_expected.to validate_presence_of :description}
    it {is_expected.to validate_presence_of :number_pages}
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_presence_of :author}
    it {is_expected.to validate_length_of(:author).is_at_most 100}
    describe "#min_publish_date" do
      let (:min_publish_date_failure) do
        FactoryBot.build :book, :failure_min
      end
      it "failure" do
        expect(min_publish_date_failure.save).to eq false
      end
    end
    describe "#max_publish_date" do
      let (:max_publish_date_failure) do
        FactoryBot.build :book, :failure_max
      end
      it "failure" do
        expect(max_publish_date_failure.save).to eq false
      end
    end
  end
end
