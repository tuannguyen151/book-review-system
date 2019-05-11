class FollowingController < ApplicationController
  before_action :find_user

  def index
    @users = @user.following.by_user_profile_name(params[:name]).order_id_desc
                  .page(params[:page]).per Settings.user_in_page
  end

  private

  def find_user
    return if @user = User.find_by(id: params[:user_id])
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_path
  end
end
