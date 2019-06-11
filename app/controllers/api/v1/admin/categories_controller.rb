class Api::V1::Admin::CategoriesController < Api::V1::Admin::AdminController
  before_action :get_category, only: %i(show update destroy)

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new category_params
    @category.save!
  end

  def show; end

  def update
    @category.update! category_params
  end

  def destroy
    @category.destroy!
  end

  private

  def category_params
    params.permit Category::CATEGORY_PARAMS
  end

  def get_category
    @category = Category.find params[:id]
  end
end
