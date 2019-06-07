class Api::V1::SessionsController < Devise::SessionsController
  before_action :load_user_authentication
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user_from_token

  def create
    return render json: {message: t(".sign_in_failed")} unless
      @user.valid_password? user_params[:password]
    sign_in @user, store: false
  end

  def destroy
    raise Exceptions::Unauthorization, t(".unauthorization") unless
      @user.authentication_token == request.headers["Authorization"]
    @user.reset_authentication_token!
    sign_out @user
    render json: {message: t(".signed_out")}
  end

  private

  def user_params
    params.permit User::USER_PARAMS
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    render json: {message: t("api.v1.email_not_found")},
      status: 404 unless @user
  end
end
