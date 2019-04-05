module BooksHelper
  def book_rate book = Book.new
    return {rate: 0, want_rate: 5} unless rate = book.reviews.average(:rate)
    rate = rate.round
    {rate: rate, want_rate: 5 - rate}
  end

  def check_image_cover book = Book.new
    book.cover_image? ? book.cover_image_url : "cover_book.png"
  end
end
