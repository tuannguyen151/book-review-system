class Api::V1::UserProfilesController < Api::V1::ApiController
  before_action :get_user
  before_action :check_user_profile
  before_action :check_current_user

  def update
    @user.user_profile.update! user_profile_params
    @user = Api::V1::UserDecorator.decorate @user
  end

  private

  def user_profile_params
    params.permit UserProfile::USER_PROFILE_PARAMS
  end

  def get_user
    @user = User.find params[:user_id]
  end

  def check_user_profile
    user_profile = UserProfile.find_by! user_id: @user
    raise ActiveRecord::RecordInvalid unless user_profile.id == params[:id].to_i
  end

  def check_current_user
    raise Exceptions::Unauthorization, t("api.v1.not_authenticated") unless
      @user.current_user? current_user
  end
end
