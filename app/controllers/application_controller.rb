class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden, content_type: "text/html"}
      format.html{redirect_to root_path, notice: exception.message}
      format.js{head :forbidden, content_type: "text/html"}
    end
  end

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

  def after_sign_in_path_for _resource
    if current_user.admin?
      admin_root_path
    else
      root_path
    end
  end
end
