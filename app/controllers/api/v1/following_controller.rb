class Api::V1::FollowingController < ApplicationController
  before_action :find_user

  def index
    @users = @user.following
        .select("users.id, user_profiles.name, user_profiles.avatar_url")
        .joins(:user_profile)
        .order_id_desc
        .page(params[:page]).per Settings.user_in_page
    @page_count = params[:page] if @users.present? && params[:page]
  end

  private

  def find_user
    @user = User.find_by!(id: params[:user_id])
  end
end