class Api::V1::ReviewsController < Api::V1::ApiController
  skip_before_action :authorize_request, only: %i(index show)
  before_action :check_not_admin, except: %i(index show)
  before_action :get_book
  before_action :get_review, only: %i(update destroy)
  before_action :check_current_user, only: %i(update destroy)

  def index
    if current_user
      @reviews = @book.reviews.includes(user: :user_profile)
                      .move_review_of_user_to_top(current_user).updated_at_desc
    else
      @reviews = @book.reviews.includes(user: :user_profile).updated_at_desc
    end
    @reviews = @reviews.page(params[:page]).per Settings.limit_review
    @reviews = Api::V1::ReviewDecorator.decorate_collection @reviews
  end

  def create
    @review = Review.new review_params
    @review.user = current_user
    @review.book = @book
    @review.save!
    @review = Api::V1::ReviewDecorator.decorate @review
  end

  def update
    @review.update! review_params
    @review = Api::V1::ReviewDecorator.decorate @review
  end

  def destroy
    @review.destroy!
    @review = Api::V1::ReviewDecorator.decorate @review
  end

  private

  def review_params
    params.permit Review::REVIEW_PARAMS
  end

  def get_review
    @review = Review.find_by! id: params[:id], book: params[:book_id]
  end

  def get_book
    @book = Book.find params[:book_id]
  end

  def check_current_user
    raise Exceptions::Unauthorization, t("api.v1.not_authenticated") unless
      @review.user.current_user? current_user
  end
end
