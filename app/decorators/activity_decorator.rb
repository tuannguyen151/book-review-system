class ActivityDecorator < Draper::Decorator
  delegate_all

  def avt_user
    helpers.check_avatar object.user.user_profile
  end

  def user_name
    object.user.user_profile.name
  end

  def marker?
    object.activitable_type == Marker.name
  end

  def relationship?
    object.activitable_type == Relationship.name
  end

  def status_maker
    helpers.status_marker(object.activitable).downcase
  end

  def book_marker
    object.activitable.book
  end

  def book_title_marker
    book_marker.title
  end

  def followed_relationship
    object.activitable.followed
  end

  def followed_name_ralationship
    followed_relationship.user_profile.name
  end

  def created_at
    l object.created_at, format: :datetime
  end
end
