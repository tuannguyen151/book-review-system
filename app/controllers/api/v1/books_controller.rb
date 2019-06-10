class Api::V1::BooksController < Api::V1::ApiController
  skip_before_action :authenticate_user_from_token, only: %i(index show)
  before_action :get_book, only: :show

  def index
    @books = Book.includes(:category).page(params[:page])
                 .per Settings.book_in_page
    @books = Api::V1::BookDecorator.decorate_collection @books
  end

  def show
    @book = Api::V1::BookDecorator.decorate @book
  end

  private

  def get_book
    @book = Book.find params[:id]
  end
end
