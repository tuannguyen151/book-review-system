RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:admin) {FactoryBot.create :user, :admin}
  let(:user) {FactoryBot.create :user, :orther_user}
  let(:book) {FactoryBot.create :book}
  let(:review) {FactoryBot.create :review, book: book, user: user}
  let(:review_orther) {FactoryBot.create :review, book: book}

  before do
    hmac_secret = Rails.application.secrets.secret_key_base
    time = Settings.exp_token
    payload = {user_id: user.id, exp: time}
    token = JWT.encode payload, hmac_secret, Settings.secret_encode
    user.update authentication_token: token
    request.headers["Authorization"] = token
  end

  describe "GET #index" do
    context "success" do
      it "logged in" do
        get :index, params: {book_id: book.id}, format: :json
        expect(response).to have_http_status :success
      end

      it "not logged in" do
        get :index, params: {book_id: book.id}, format: :json
        request.headers["Authorization"] = nil
        expect(response).to have_http_status :success
      end
    end

    context "failure" do
      it "book not found" do
        get :index, params: {book_id: 1}, format: :json
        expect(response).to have_http_status 404
      end
    end
  end

  describe "POST #create" do
    it "success" do
      post :create, params: {book_id: book.id, rate: 5, content: "xxx"},
        format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "admin forbidden" do
        hmac_secret = Rails.application.secrets.secret_key_base
        time = Settings.exp_token
        payload = {user_id: admin.id, exp: time}
        token = JWT.encode payload, hmac_secret, Settings.secret_encode
        admin.update authentication_token: token
        request.headers["Authorization"] = token
        post :create, params: {book_id: book.id, rate: 5, content: "xxx"},
          format: :json
        expect(response).to have_http_status 403
      end

      it "unauthorization" do
        request.headers["Authorization"] = nil
        post :create, params: {book_id: book.id, rate: 5, content: "xxx"},
          format: :json
        expect(response).to have_http_status 401
      end

      it "invalid" do
        post :create, params: {book_id: book.id}, format: :json
        expect(response).to have_http_status 400
      end

      it "book not found" do
        post :create, params: {book_id: 1}, format: :json
        expect(response).to have_http_status 404
      end
    end
  end

  describe "PUT #update" do
    it "success" do
      put :update, params: {book_id: book.id, id: review.id,
        rate: 4, content: "xxx"}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "admin forbidden" do
        hmac_secret = Rails.application.secrets.secret_key_base
        time = Settings.exp_token
        payload = {user_id: admin.id, exp: time}
        token = JWT.encode payload, hmac_secret, Settings.secret_encode
        admin.update authentication_token: token
        request.headers["Authorization"] = token
        put :update, params: {book_id: book.id, id: review.id,
          rate: 5, content: "xxx"}, format: :json
        expect(response).to have_http_status 403
      end

      it "unauthorization" do
        request.headers["Authorization"] = nil
        put :update, params: {book_id: book.id, id: review.id,
          rate: 5, content: "xxx"}, format: :json
        expect(response).to have_http_status 401
      end

      it "review of orther user" do
        put :update, params: {book_id: book.id, id: review_orther.id,
          rate: 4, content: "xxx"}, format: :json
        expect(response).to have_http_status 401
      end

      it "book not found" do
        put :update, params: {book_id: 1, id: review.id}, format: :json
        expect(response).to have_http_status 404
      end

      it "review not found" do
        put :update, params: {book_id: book.id, id: 1}, format: :json
        expect(response).to have_http_status 404
      end
    end
  end

  describe "DELETE #destroy" do
    it "success" do
      delete :destroy, params: {book_id: book.id, id: review.id}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "admin forbidden" do
        hmac_secret = Rails.application.secrets.secret_key_base
        time = Settings.exp_token
        payload = {user_id: admin.id, exp: time}
        token = JWT.encode payload, hmac_secret, Settings.secret_encode
        admin.update authentication_token: token
        request.headers["Authorization"] = token
        delete :destroy, params: {book_id: book.id, id: review.id},
          format: :json
        expect(response).to have_http_status 403
      end

      it "unauthorization" do
        request.headers["Authorization"] = nil
        delete :destroy, params: {book_id: book.id, id: review.id},
          format: :json
        expect(response).to have_http_status 401
      end

      it "review of orther user" do
        delete :destroy, params: {book_id: book.id, id: review_orther.id},
          format: :json
        expect(response).to have_http_status 401
      end

      it "book not found" do
        delete :destroy, params: {book_id: 1, id: review.id}, format: :json
        expect(response).to have_http_status 404
      end

      it "review not found" do
        delete :destroy, params: {book_id: book.id, id: 1}, format: :json
        expect(response).to have_http_status 404
      end
    end
  end
end
