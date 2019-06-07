RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) {FactoryBot.create :user, :user_devise}

  before do
    user
    set_request_user
  end

  describe "POST #create" do
    it "sign in success" do
      post :create, params: {email: user.email, password: user.password},
        format: :json
      expect(response).to have_http_status :success
    end

    context "sign in failure" do
      it "Sign in failed" do
        post :create, params: {email: user.email, password: 1},
          format: :json
        parse_json = JSON(response.body)
        expect(parse_json["message"]).to eq I18n.t("api.v1.sessions.create.sign_in_failed")
      end

      it "Invalid login" do
        post :create, params: {email: "1", password: user.password},
          format: :json
        parse_json = JSON(response.body)
        expect(parse_json["message"]).to eq I18n.t("api.v1.email_not_found")
      end
    end
  end

  describe "DELETE #create" do
    before do
      sign_in user, scope: :user
    end

    it "sign out success" do
      request.headers["Authorization"] = user.authentication_token
      delete :destroy, params: {email: user.email}, format: :json
      expect(response).to have_http_status 200
    end

    it "Invalid token" do
      delete :destroy, params: {email: user.email}, format: :json
      expect(response).to have_http_status 401
    end
  end
end
