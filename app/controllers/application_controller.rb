class ApplicationController < ActionController::Base
  before_action :set_locale

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
