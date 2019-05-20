class UsersController < ApplicationController
  autocomplete :user_profile, :name, full: true
  before_action :find_user

  def show
    @user = UserDecorator.decorate @user
  end

  private

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_path
  end
end
