class RelationshipsController < ApplicationController
  authorize_resource
  before_action :get_followed_user, only: %i(create destroy)

  def create
    current_user.following << @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.following.delete @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def get_followed_user
    return if @user = User.find_by(id: params[:user_id])
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_path
  end
end
