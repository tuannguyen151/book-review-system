class ReadedBooksController < ApplicationController
  authorize_resource class: Marker
  before_action :get_readed_book, only: %i(destroy)

  def index
    @readed_books = current_user.markers.created_at_desc
                                .where(status: :readed).includes(:book)
  end

  def destroy
    @marker.destroy
    flash[:success] = t ".success"
    redirect_to readed_books_path
  end

  private

  def get_readed_book
    return if @marker = current_user.markers.find_by(id: params[:id])
    flash[:danger] = t ".readed_book_not_found"
    redirect_to readed_books_path
  end
end
