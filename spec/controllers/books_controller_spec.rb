RSpec.describe BooksController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:user) {FactoryBot.create :user, :admin}
  let(:book) {FactoryBot.create :book}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #new" do
    before do
      sign_in user, scope: :user
    end
    it "returns http success" do
      get :new
      expect(response).to have_http_status :success
    end
  end

  describe "POST #create" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      post :create, params: {book: {title: "xxx", description: "xxx",
        number_pages: 10, publish_date: "1990-01-01", price: 10, author: "TSN",
          category_id: category.id}}
      expect(response).to have_http_status 302
    end

    it "failure" do
      post :create, params: {book: {title: "xxx"}}
      expect(response).to have_http_status 200
    end
  end

  describe "Get #edit" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      get :edit, params: {id: book.id}
      expect(response).to have_http_status :success
    end
  end

  describe "PATCH #update" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      patch :update, params: {id: book.id, book: {title: "xxx"}}
      expect(response).to have_http_status 302
    end

    context "failure" do
      it "save failure" do
        patch :update, params: {id: book.id, book: {publish_date: "1000-01-01"}}
        expect(response).to have_http_status 200
      end

      it "not found book" do
        patch :update, params: {id: 1}
        expect(response).to have_http_status 302
      end
  describe "GET #show" do
    it "returns http success" do
      book_path(book.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      delete :destroy, params: {id: book.id}
      expect(response).to have_http_status 302
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      delete :destroy, params: {id: book.id}
      expect(response).to have_http_status 302
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      delete :destroy, params: {id: book.id}
      expect(response).to have_http_status 302
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in user, scope: :user
    end

    it "success" do
      delete :destroy, params: {id: book.id}
      expect(response).to have_http_status 302
    end
  end
end
