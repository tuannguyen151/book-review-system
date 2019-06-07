class Api::V1::UsersController < ApplicationController
  def index
    @users = User.where(admin: false).includes :user_profile
    @users = Api::V1::UserDecorator.decorate_collection @users
  end
end
