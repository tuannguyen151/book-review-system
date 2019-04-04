RSpec.describe Admin::HomeController, type: :controller do
  describe "GET #index" do
    let(:user) {FactoryBot.create :user, :admin}

    before do
      sign_in user, scope: :user
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
