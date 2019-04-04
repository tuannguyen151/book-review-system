module ControllerMacros
  def set_request_user
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
end
