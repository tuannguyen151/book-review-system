RSpec.describe Api::V1::UserProfilesController, type: :controller do
  let(:user) {FactoryBot.create :user, :orther_user}
  let(:user_profile) {FactoryBot.create :user_profile, user: user}

  before do
    sign_in user, scope: :user
    request.headers["Authorization"] = user.authentication_token
  end

  describe "PUT #update" do
    it "update success" do
      put :update, params: {user_id: user, id: user_profile,
        user_profile: {name: "xxx"}}, format: :json
      expect(response).to have_http_status :success
    end

    context "update failure" do
      it "user profile not found!" do
        put :update, params: {user_id: user, id: 1,
          user_profile: {name: "xxx"}}, format: :json
        expect(response).to have_http_status 404
      end

      it "invalid" do
        name = "123456789" * 100
        put :update, params: {user_id: user, id: user_profile,
          user_profile: {name: name}}, format: :json
        expect(response).to have_http_status 400
      end
    end
  end
end
