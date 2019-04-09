class UsersController < ApplicationController
  authorize_resource class: UserProfile

  def show
    @profile = User.find_by(id: params[:id]).user_profile
  end
end
