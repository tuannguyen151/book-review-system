class ReviewsController < ApplicationController
  before_action :find_review, only: %i(show edit update destroy)
  before_action :find_book
  before_action :authenticate_user!, only: %i(new edit create)

  def create
    @review = ReviewsService.new(
      review_params: review_params, user: current_user, book: @book
    ).builder
    respond_to do |format|
      if @review.save
        flash[:success] = t ".create_success"
      else
        flash[:danger] = t ".create_failure"
      end
      format.html{redirect_to book_path(@book)}
      format.js
    end
  end

  def edit; end

  def update
    if @review.update review_params
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @review.destroy
        flash[:success] = t ".destroy_success"
      else
        flash[:danger] = t ".destroy_failure"
      end
      format.html{redirect_to book_path(@book)}
      format.js
    end
  end

  private

  def find_review
    return if @review = Review.find_by(id: params[:id])
    flash[:danger] = t ".review_not_found"
    redirect_back fallback_location: books_path
  end

  def find_book
    return if @book = BookDecorator.decorate(Book.find params[:book_id])
    flash[:danger] = t ".book_not_found"
    redirect_back fallback_location: books_path
  end

  def review_params
    params.require(:review).permit :rate, :content
  end
end
