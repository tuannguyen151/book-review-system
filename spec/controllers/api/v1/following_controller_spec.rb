RSpec.describe Api::V1::FollowingController, type: :controller do
  let(:user) {FactoryBot.create :user, :orther_user}

  describe "GET #index" do
    it "responds to json by default" do
      get :index, params: {user_id: user.id, page: 1, format: :json}
      expect(response.content_type).to eq "application/json"
    end

    it "user not found" do
      get :index, params: {user_id: 1, page: 1, format: :json}
      parse_json = JSON(response.body)
      expect(parse_json["status"]).to eq 404
    end
  end
end
