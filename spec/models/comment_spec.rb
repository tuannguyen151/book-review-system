RSpec.describe Comment, type: :model do
  subject {FactoryBot.create :comment}

  context "associations" do
    it {is_expected.to belong_to :commentable}
    it {is_expected.to belong_to :user}
  end
end
