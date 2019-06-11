class Api::V1::Admin::BooksController < Api::V1::Admin::AdminController
  before_action :check_category, only: %i(create update)
  before_action :get_book, only: %i(update destroy)

  def create
    @book = Book.new book_params
    @book.save!
    @book = Api::V1::BookDecorator.decorate @book
  end

  def update
    @book.update! book_params
    @book = Api::V1::BookDecorator.decorate @book
  end

  def destroy
    @book.destroy!
  end

  private

  def get_book
    @book = Book.find params[:id]
  end

  def book_params
    params.permit Book::BOOK_PARAMS
  end

  def check_category
    Category.find params[:category_id]
  end
end
