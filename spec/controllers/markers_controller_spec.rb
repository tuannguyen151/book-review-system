RSpec.describe MarkersController, type: :controller do
  let(:user) {FactoryBot.create :user, :user_devise}
  let(:book) {FactoryBot.create :book}
  let(:marker) {FactoryBot.create :marker, book: book, user: user}

  before do
    sign_in user, scope: :user
  end

  describe "POST #create" do
    it "success" do
      post :create, params: {book_id: book.id, status: "favorite"}, xhr: true
      expect(response).to have_http_status 200
    end

    it "failure" do
      post :create, params: {book_id: 1, status: "favorite"}, xhr: true
      expect(response).to have_http_status 200
    end
  end

  describe "DELETE #destroy" do
    it "success" do
      delete :destroy, params: {book_id: book.id, id: marker.id}, xhr: true
      expect(response).to have_http_status 200
    end

    it "marker not found" do
      delete :destroy, params: {book_id: 1, id: marker.id}, xhr: true
      expect(response).to have_http_status 200
    end
  end

end
