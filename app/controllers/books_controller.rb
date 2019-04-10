class BooksController < ApplicationController
  authorize_resource
  before_action :get_categories
  before_action :get_book, only: %i(show edit update destroy)

  def index
    @books = Book.includes(:category).page(params[:page])
                 .per Settings.book_in_page
  end

  def show
    @reviews = Review.where(book_id: @book.id).order_desc.page(params[:page])
                     .per Settings.limit_review
    @average_review = if @reviews.blank?
                        0
                      else
                        Review.where(book_id: @book.id).average(:rate)
                              .round(Settings.average_rate)
                      end
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

  def edit; end

  def update
    if @book.update book_params
      flash[:success] = t ".update_success"
      redirect_to books_path
    else
      flash.now[:danger] = t ".update_failure"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t ".delete_success"
      redirect_to books_path
    else
      flash[:danger] = t ".delete_failure"
      redirect_back fallback_location: books_path
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

  def get_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_back fallback_location: books_path
  end
end
