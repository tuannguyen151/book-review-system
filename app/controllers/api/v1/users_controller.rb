class Api::V1::UsersController < Api::V1::ApiController
  before_action :get_user, only: :show
  skip_before_action :authorize_request

  def index
    @users = User.where(admin: false).includes :user_profile
    @users = Api::V1::UserDecorator.decorate_collection @users
  end

  def show; end

  private

  def get_user
    @user = User.find_by! id: params[:id]
    @user = Api::V1::UserDecorator.decorate @user
  end
end
