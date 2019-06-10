RSpec.describe Api::V1::Admin::BooksController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:admin) {FactoryBot.create :user, :admin}
  let(:user) {FactoryBot.create :user, :orther_user}

  describe "POST #create" do
    before do
      sign_in admin, scope: :admin
      request.headers["Authorization"] = admin.authentication_token
    end

    it "success" do
      post :create, params: {title: "xxx", description: "xxx",
        number_pages: 10, publish_date: "1990-01-01", price: 10, author: "TSN",
          category_id: category.id}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "forbidden", skip_before: true do
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
    end
  end
end
