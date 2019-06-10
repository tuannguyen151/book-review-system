class Api::V1::Admin::BooksController < Api::V1::Admin::AdminController
  before_action :check_category, only: :create

  def create
    @book = Book.new book_params
    @book.save!
    @book = Api::V1::BookDecorator.decorate @book
  end

  private

  def book_params
    params.permit Book::BOOK_PARAMS
  end

  def check_category
    Category.find params[:category_id]
  end
end
