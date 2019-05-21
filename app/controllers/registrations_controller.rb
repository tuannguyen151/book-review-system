class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource
    resource.build_user_profile
    respond_with resource
  end
end
