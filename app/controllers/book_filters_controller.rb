class BookFiltersController < ApplicationController
  def index
    @books = BooksService.new(filter_query_params).filter
    @books = Kaminari.paginate_array(@books).page(params[:page])
                     .per Settings.book_in_page
    @books = BookDecorator.decorate_collection @books
  end

  private

  def filter_query_params
    params.slice :category, :title, :author, :price_from, :price_to, :rate_from
  end
end
