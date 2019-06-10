class Api::V1::BookDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def cover_image_url
    return h.asset_url "cover_book.png" unless object.cover_image?
    h.asset_url object.user_profile.cover_image_url
  end

  def category_name
    object.category.name
  end

  def category_id
    object.category.id
  end
end
