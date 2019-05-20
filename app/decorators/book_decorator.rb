class BookDecorator < Draper::Decorator
  delegate_all

  def average_reviews
    return 0 if object.reviews.blank?
    object.reviews.average(:rate).round Settings.average_rate
  end

  def count_reviews
    object.reviews.length
  end
end
