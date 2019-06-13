class Api::V1::ReviewDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def user_id
    object.user.id
  end

  def user_profile_name
    object.user.user_profile.name
  end
end
