class ReviewsService
  def initialize params
    @review_params = params[:review_params]
    @user = params[:user]
    @book = params[:book]
  end

  def builder
    review = Review.new @review_params
    review.user = @user
    review.book = @book
    ReviewDecorator.decorate review
  end
end
