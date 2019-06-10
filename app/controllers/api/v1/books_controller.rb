class Api::V1::BooksController < Api::V1::ApiController
  skip_before_action :authenticate_user_from_token
  before_action :get_book, only: :show

  def show
    @book = Api::V1::BookDecorator.decorate @book
  end

  private

  def get_book
    @book = Book.find params[:id]
  end
end
