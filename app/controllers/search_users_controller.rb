class SearchUsersController < ApplicationController
  def index
    return if @profile = UserProfile.find_by(name: params[:name])
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_path
  end
end
