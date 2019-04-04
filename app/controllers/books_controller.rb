class BooksController < ApplicationController
  def index
    @books = Book.includes(:category).page(params[:page])
                 .per Settings.book_in_page
  end
end
