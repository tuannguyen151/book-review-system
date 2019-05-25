class BooksService
  attr_reader :params

  def initialize params = {}
    @params = params
  end

  def filter
    books_by_category = BooksQuery.new.category_name params[:category]
    books_by_title = BooksQuery.new(books_by_category)
                               .title_like params[:title]
    books_by_author = BooksQuery.new(books_by_title)
                                .author params[:author]
    books_by_price_from = BooksQuery.new(books_by_author)
                                    .minimal_price params[:price_from]
    books_by_price_to = BooksQuery.new(books_by_price_from)
                                  .maximal_price params[:price_to]
    BooksQuery.new(books_by_price_to).minimal_rate_from params[:rate_from]
  end
end
