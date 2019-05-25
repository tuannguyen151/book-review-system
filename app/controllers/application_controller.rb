class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden, content_type: "text/html"}
      format.html{redirect_to root_path, notice: exception.message}
      format.js{head :forbidden, content_type: "text/html"}
    end
  end

  rescue_from ActiveRecord::RecordNotFound,
    with: :render_record_not_found_response

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def admin?
    redirect_back fallback_location: root_path unless
      current_user && current_user.admin?
  end

  def current_user?
    redirect_back fallback_location: root_path unless current_user
  end

  def after_sign_in_path_for _resource
    if current_user.admin?
      admin_root_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |user|
      user.permit :email, :password, :password_confirmation,
        user_profile_attributes: [:name, :birthday, :gender]
    end
  end

  def render_record_not_found_response error
    render json: {message: error, status: 404}
  end
end
