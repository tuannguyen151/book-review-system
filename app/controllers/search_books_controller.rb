class SearchBooksController < ApplicationController
  def index
    return if @book = Book.find_by(title: params[:title])
    flash[:danger] = t ".not_found"
    redirect_back fallback_location: books_path
  end
end
