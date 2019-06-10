RSpec.describe Api::V1::BooksController, type: :controller do
  let(:book) {FactoryBot.create :book}

  describe "GET #show" do
    it "success" do
      get :show, params: {id: book.id}, format: :json
      expect(response).to have_http_status :success
    end

    it "failure" do
      get :show, params: {id: 1}, format: :json
      expect(response).to have_http_status 404
    end
  end
end
