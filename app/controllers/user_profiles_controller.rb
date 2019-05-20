class UserProfilesController < ApplicationController
  before_action :get_user_profile

  def update
    if @user_profile.update user_profile_params
      flash[:success] = t ".update_profile_success"
    else
      flash[:danger] = t ".update_profile_failure"
    end
    redirect_to user_path(current_user)
  end

  private

  def user_profile_params
    params.require(:user_profile).permit :avatar_url, :name, :gender, :birthday,
      :phone, :address
  end

  def get_user_profile
    return if @user_profile = UserProfile.find_by(user_id: params[:user_id],
      id: params[:id])
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: user_path(current_user)
  end
end
