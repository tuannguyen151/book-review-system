RSpec.describe Api::V1::Admin::CategoriesController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:admin) {FactoryBot.create :user, :admin}
  let(:user) {FactoryBot.create :user, :orther_user}

  before do
    sign_in admin, scope: :admin
    request.headers["Authorization"] = admin.authentication_token
  end

  describe "GET #index" do
    it "success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "forbidden" do
        sign_in user, scope: :user
        request.headers["Authorization"] = user.authentication_token
        get :index, format: :json
        expect(response).to have_http_status 403
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        get :index, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "POST #create" do
    it "success" do
      post :create, params: {name: "xxx"}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "forbidden" do
        sign_in user, scope: :user
        request.headers["Authorization"] = user.authentication_token
        post :create, params: {name: "xxx"}, format: :json
        expect(response).to have_http_status 403
      end

      it "invalid" do
        name = "0123456789" * 30
        post :create, params: {name: name}, format: :json
        expect(response).to have_http_status 400
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        post :create, params: {name: "xxx"}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "GET #show" do
    it "success" do
      get :show, params: {id: category.id}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "not found" do
        get :show, params: {id: 1}, format: :json
        expect(response).to have_http_status 404
      end

      it "forbidden" do
        sign_in user, scope: :user
        request.headers["Authorization"] = user.authentication_token
        get :show, params: {id: category.id}, format: :json
        expect(response).to have_http_status 403
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        get :show, params: {id: category.id}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "PUT #update" do
    it "success" do
      put :update, params: {id: category.id, name: "xxx"}, format: :json
      expect(response).to have_http_status :success
    end

    context "failure" do
      it "not found" do
        put :update, params: {id: 1, name: "xxx"}, format: :json
        expect(response).to have_http_status 404
      end

      it "forbidden" do
        sign_in user, scope: :user
        request.headers["Authorization"] = user.authentication_token
        put :update, params: {id: 1, name: "xxx"}, format: :json
        expect(response).to have_http_status 403
      end

      it "invalid" do
        name = "0123456789" * 30
        put :update, params: {id: category.id, name: name}, format: :json
        expect(response).to have_http_status 400
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        put :update, params: {id: 1, name: "xxx"}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "DELETE #destroy" do
    it "success" do
      delete :destroy, params: {id: category.id}, format: :json
      expect(response).to have_http_status 200
    end

    context "failure" do
      it "not found" do
        delete :destroy, params: {id: 1}, format: :json
        expect(response).to have_http_status 404
      end

      it "forbidden" do
        sign_in user, scope: :user
        request.headers["Authorization"] = user.authentication_token
        delete :destroy, params: {id: category.id}, format: :json
        expect(response).to have_http_status 403
      end

      it "Unauthorization" do
        request.headers["Authorization"] = nil
        delete :destroy, params: {id: category.id}, format: :json
        expect(response).to have_http_status 401
      end
    end
  end

end
