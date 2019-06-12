class Api::V1::SessionsController < Devise::SessionsController
  before_action :load_user_authentication, only: :create
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize_request, only: :create

  def create
    return render json: {message: t(".sign_in_failed")} unless
      @user.valid_password?(params[:password])
    token = generate_and_update_authentication_token @user, Settings.exp_token
    render json: {message: t(".signed_in_successfully"), token: token}
  end

  def destroy
    generate_and_update_authentication_token current_user, Time.now.to_i
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
