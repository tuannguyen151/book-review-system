RSpec.describe FavoritesController, type: :controller do

  let(:user) {FactoryBot.create :user, :user_devise}
  let(:marker) {FactoryBot.create :marker, user: user}

  before do
    sign_in user, scope: :user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "DELETE #destroy" do
    it "success" do
      delete :destroy, params: {id: marker.id}
      expect(response).to have_http_status 302
    end

    it "failure" do
      delete :destroy, params: {id: 1}
      expect(response).to have_http_status 302
    end
  end

end
