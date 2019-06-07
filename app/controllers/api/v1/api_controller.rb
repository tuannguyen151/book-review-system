class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound,
    with: :render_record_not_found_response
  rescue_from Exceptions::Unauthorization, with: :render_not_authenticated

  private

  def render_record_not_found_response error
    render json: {message: error}, status: 404
  end

  def current_user
    @current_user ||= User.find_by(
      authentication_token: request.headers["Authorization"]
    )
  end

  def authenticate_user_from_token
    render json: {message: t("api.v1.not_authenticated")},
      status: 401 if current_user.nil? || !current_user.authentication_token?
  end

  def render_not_authenticated error
    render json: {message: error}, status: 401
  end
end
