class UserBookSearchesController < ApplicationController
  def index
    @users = User.by_user_profile_name(params[:q])
    @books = Book.where "title LIKE ?", "%#{params[:q]}%"
    @users = UserDecorator.decorate_collection @users
    @books = BookDecorator.decorate_collection @books
    respond_to do |format|
      format.js
      format.html
    end
  end
end
