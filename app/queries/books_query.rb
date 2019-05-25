class BooksQuery
  attr_reader :relation

  def initialize relation = Book.includes(:reviews, :category)
    @relation = relation
  end

  def title_like title
    return relation unless title.present?
    relation.where "title LIKE ?", "%#{title}%"
  end

  def category_name category
    return relation unless category.present?
    relation.where categories: {name: category}
  end

  def author author
    return relation unless author.present?
    relation.where author: author
  end

  def minimal_price price_from
    return relation unless price_from.present?
    relation.where "price >= ?", price_from
  end

  def maximal_price price_to
    return relation unless price_to.present?
    relation.where "price <= ?", price_to
  end

  def minimal_rate_from rate_from
    return relation if rate_from.to_i == 0
    relation.where id: Review.select(:book_id).group(:book_id)
                             .having("avg(rate) >= ?", rate_from)
  end
end
