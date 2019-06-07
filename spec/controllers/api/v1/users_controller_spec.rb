RSpec.describe Api::V1::UsersController, type: :controller do

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
end
