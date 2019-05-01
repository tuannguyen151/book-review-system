class UsersController < ApplicationController
  autocomplete :user_profile, :name, full: true

  def show
    @user = User.find_by id: params[:id]
  end
end
