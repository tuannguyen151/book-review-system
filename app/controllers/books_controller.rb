class BooksController < ApplicationController
  authorize_resource
  before_action :get_categories, only: %i(new create)

  def index
    @books = Book.includes(:category).page(params[:page])
                 .per Settings.book_in_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params

    if @book.save
      flash[:success] = t ".create_success"
      redirect_to books_path
    else
      flash.now[:danger] = t ".create_failure"
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit :title, :cover_image, :description,
      :number_pages, :publish_date, :price, :author, :category_id
  end

  def get_categories
    @categories = Category.pluck :name, :id
  end
end
