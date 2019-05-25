class ReviewsService
  attr_reader :params

  def initialize params = {}
    @params = params[:review_params]
    @user = params[:user]
    @book = params[:book]
  end

  def builder
    params[:user] = @user
    params[:book] = @book
    Review.new params
  end
end
