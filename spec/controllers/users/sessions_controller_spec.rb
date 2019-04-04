RSpec.describe Users::SessionsController, type: :controller do
  describe "POST #create" do
    let(:user) {FactoryBot.create :user, :user_devise}
    let(:user_unconfirm) {FactoryBot.create :user, :unconfirm}

    before do
      user
      set_request_user
    end

    context "sign in failure" do
      it "not found in database" do
        post :create, params: {user: {email: "user1@email.com",
            password: "123123"}}, xhr: true
        expect(response).to have_http_status(200)
      end

      it "invalid" do
        post :create, params: {user: {email: "user@gmail.com",
            password: "1231231"}}, xhr: true
        expect(response).to have_http_status(200)
      end

      it "unconfirmed" do
        user_unconfirm
        post :create, params: {user: {email: "user1@gmail.com",
            password: "123123"}}, xhr: true
        expect(response).to have_http_status(200)
      end
    end

    it "success" do
      post :create, params: {user: {email: "user@gmail.com",
          password: "123123"}}, xhr: true
      expect(response).to have_http_status(200)
    end
  end
end
