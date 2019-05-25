class BooksController < ApplicationController
  autocomplete :book, :title, full: true
  before_action :get_categories
  before_action :get_book, only: %i(show edit update destroy)
  before_action :admin?, only: %i(new create edit update destroy)

  def index
    @categories = Category.all.pluck :name
    @books = Book.includes(:category, :markers).page(params[:page])
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

  def show
    review_of_current_user = @book.reviews.where(user: current_user)
    @reviews = @book.reviews.where.not(user: current_user)
                    .includes(user: :user_profile).updated_at_desc
    @reviews = Kaminari.paginate_array(review_of_current_user + @reviews)
                       .page(params[:page]).per Settings.limit_review
    @reviews = ReviewDecorator.decorate_collection @reviews
    @book = BookDecorator.decorate @book
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
