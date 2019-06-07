class Api::V1::ApiController < ApplicationController
  acts_as_token_authentication_handler_for User, {fallback: :none}
  protect_from_forgery with: :null_session
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound,
    with: :render_record_not_found_response

  private

  def render_record_not_found_response error
    render json: {message: error, status: 404}
  end

  def current_user
    @current_user ||= User.find_by(
      authentication_token: request.headers["Authorization"]
    )
  end

  def authenticate_user_from_token
    render json: {message: "You are not authenticated"},
      status: 401 if current_user.nil?
  end

  def ensure_params_exist
   return unless params[:user].blank?
    render json: {message: "Missing params"}, status: 422
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    return login_invalid unless @user
  end

  def login_invalid
    render json: {message: "Invalid login"}, status: 200
  end
end
