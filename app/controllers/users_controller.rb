class UsersController < ApplicationController
  autocomplete :user_profile, :name, full: true

  def show
    @profile = User.find_by(id: params[:id]).user_profile
  end
end
