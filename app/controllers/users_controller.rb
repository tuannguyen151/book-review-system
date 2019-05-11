class UsersController < ApplicationController
  autocomplete :user_profile, :name, full: true
  before_action :find_user

  def show
    @count_following = @user.following.length
    @following = @user.following.order_id_desc.limit(6).includes :user_profile
    @count_followers = @user.followers.length
    @followers = @user.followers.order_id_desc.limit(6).includes :user_profile
  end

  private

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_path
  end
end
