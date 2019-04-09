class ReadingBooksController < ApplicationController
  authorize_resource class: Marker
  before_action :get_reading_book, only: %i(destroy)

  def index
    @reading_books = current_user.markers.created_at_desc
                                 .where(status: :reading).includes(:book)
  end

  def destroy
    @marker.destroy
    flash[:success] = t ".success"
    redirect_to reading_books_path
  end

  private

  def get_reading_book
    return if @marker = current_user.markers.find_by(id: params[:id])
    flash[:danger] = t ".reading_book_not_found"
    redirect_to reading_books_path
  end
end
