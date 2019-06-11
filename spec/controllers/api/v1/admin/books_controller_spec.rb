RSpec.describe Api::V1::Admin::BooksController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:book) {FactoryBot.create :book, category: category}
  let(:admin) {FactoryBot.create :user, :admin}
  let(:user) {FactoryBot.create :user, :orther_user}

  before do
    sign_in admin, scope: :admin
    request.headers["Authorization"] = admin.authentication_token
  end

  describe "POST #create" do
    it "success" do
      post :create, params: {title: "xxx", description: "xxx",
        number_pages: 10, publish_date: "1990-01-01", price: 10, author: "TSN",
          category_id: category.id}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "forbidden" do
        sign_in user, scope: :user
        request.headers["Authorization"] = user.authentication_token
        post :create, params: {title: "xxx", description: "xxx",
          number_pages: 10, publish_date: "1990-01-01", price: 10,
          author: "TSN", category_id: category.id}, format: :json
        expect(response).to have_http_status 403
      end

      it "category failure" do
        post :create, params: {title: "xxx", description: "xxx",
          number_pages: 10, publish_date: "1990-01-01", price: 10,
            author: "TSN", category_id: 1}, format: :json
        expect(response).to have_http_status 404
      end

      it "invalid" do
        post :create, params: {category_id: category.id}, format: :json
        expect(response).to have_http_status 400
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        post :create, params: {title: "xxx", description: "xxx",
          number_pages: 10, publish_date: "1990-01-01", price: 10,
          author: "TSN", category_id: category.id}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "PUT #update" do
    it "success" do
      put :update, params: {id: book.id, title: "xxx", description: "xxx",
        number_pages: 10, publish_date: "1990-01-01", price: 10, author: "TSN",
          category_id: category.id}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "not found" do
        put :update, params: {id: 1}, format: :json
        expect(response).to have_http_status 404
      end

      it "invalid" do
        title = "0123456789" * 30
        put :update, params: {id: book.id, title: title,
          category_id: category.id}, format: :json
        expect(response).to have_http_status 400
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        put :update, params: {id: book.id, title: "xxx", description: "xxx",
          number_pages: 10, publish_date: "1990-01-01", price: 10,
          author: "TSN", category_id: category.id}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "DELETE #destroy" do
    it "success" do
      delete :destroy, params: {id: book.id}, format: :json
      expect(response).to have_http_status 200
    end

    context "failure" do
      it "not found" do
        delete :destroy, params: {id: 1}, format: :json
        expect(response).to have_http_status 404
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        delete :destroy, params: {id: book.id}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end
end
