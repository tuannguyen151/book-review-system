RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) {FactoryBot.create :user, :orther_user}

  describe "GET #index" do
    it "returns json success" do
      get :index, format: :json
      expect(response.content_type).to eq "application/json"
    end

    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show" do
    it "responds to json by default" do
      get :show, params: {id: user.id, format: :json}
      expect(response.content_type).to eq "application/json"
    end

    it "returns http success" do
      get :show, params: {id: user.id, format: :json}
      expect(response).to have_http_status :success
    end

    it "user not found" do
      get :show, params: {id: 1, format: :json}
      parse_json = JSON(response.body)
      expect(parse_json["status"]).to eq 404
    end
  end

  describe "GET #show" do
    it "responds to json by default" do
      get :show, params: {id: user.id, format: :json}
      expect(response.content_type).to eq "application/json"
    end

    it "user not found" do
      get :show, params: {id: 1, format: :json}
      parse_json = JSON(response.body)
      expect(parse_json["status"]).to eq 404
    end
  end
end
