class Api::V1::Admin::AdminController < Api::V1::ApiController
  before_action :check_admin

  private

  def check_admin
    render json: {message: t("api.v1.forbidden")}, status: 403 unless
      current_user.admin?
  end
end
