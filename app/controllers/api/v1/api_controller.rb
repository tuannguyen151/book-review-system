class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authorize_request
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound,
    with: :render_record_not_found_response
  rescue_from Exceptions::Unauthorization, with: :render_not_authenticated
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  private

  def render_record_not_found_response error
    render json: {message: error}, status: 404
  end

  def current_user
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    hmac_secret = Rails.application.secrets.secret_key_base
    begin
      decoded_token = JWT.decode header, hmac_secret, true,
        {algorithm: Settings.secret_encode}
      @current_user = User.find decoded_token[0]["user_id"]
    rescue; end
  end

  def render_not_authenticated error
    render json: {message: error}, status: 401
  end

  def render_record_invalid error
    render json: {message: error}, status: 400
  end

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    hmac_secret = Rails.application.secrets.secret_key_base
    begin
      decoded_token = JWT.decode header, hmac_secret, true,
        {algorithm: Settings.secret_encode}
      @current_user = User.find decoded_token[0]["user_id"]
      JWT.decode @current_user.authentication_token, hmac_secret, true,
        {algorithm: Settings.secret_encode}
    rescue StandardError => e
      render json: {errors: e.message}, status: 401
    end
  end

  def generate_and_update_authentication_token user, exp_time
    hmac_secret = Rails.application.secrets.secret_key_base
    time = exp_time
    payload = {user_id: user.id, exp: time}
    token = JWT.encode payload, hmac_secret, Settings.secret_encode
    user.update authentication_token: token
    return token
  end

  def check_not_admin
    render json: {message: t("api.v1.forbidden")}, status: 403 if
      current_user.admin?
  end
end
