class Users::SessionsController < Devise::SessionsController
  def create
    resource = get_user

    return handle_failure :not_found_in_database unless resource

    return handle_failure :invalid unless
      resource.valid_password? params[:user][:password]

    return handle_failure :unconfirmed unless
      resource.active_for_authentication?

    resource = warden.authenticate!(auth_options) if
      params[:user][:remember_me] == Settings.remember
    handle_success resource
  end

  private

  def get_user
    User.find_for_database_authentication email: params[:user][:email]
  end

  def handle_failure fail_value
    set_flash_message :danger, fail_value
    respond_to do |format|
      format.js
    end
  end

  def handle_success resource
    set_flash_message :primary, :signed_in
    sign_in :user, resource
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
