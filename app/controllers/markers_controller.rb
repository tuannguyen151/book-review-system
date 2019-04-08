class MarkersController < ApplicationController
  authorize_resource
  before_action :get_book
  before_action :get_marker, only: %i(destroy)

  def create
    @marker = current_user.markers.new book_id: params[:book_id],
      status: params[:status]
    respond_to do |format|
      if @marker.save
        format.js
      else
        format.js{redirect_to books_path}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @marker.destroy
        format.js
      else
        format.js{redirect_to books_path}
      end
    end
  end

  private

  def get_book
    return if @book = Book.find_by(id: params[:book_id])
    flash[:danger] = t ".book_not_found"
    redirect_back fallback_location: books_path
  end

  def get_marker
    return if @marker = current_user.markers.find_by(book_id: params[:book_id],
      id: params[:id])
    flash[:danger] = t ".marker_not_found"
    redirect_back fallback_location: books_path
  end
end
