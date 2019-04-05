RSpec.describe BooksController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:user) {FactoryBot.create :user, :admin}

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
end
