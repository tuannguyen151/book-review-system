class UserDecorator < Draper::Decorator
  delegate_all

  def count_following
    object.following.length
  end

  def count_followers
    object.followers.length
  end

  def user_following
    object.following.order_id_desc.limit(6).includes :user_profile
  end

  def user_followers
    object.followers.order_id_desc.limit(6).includes :user_profile
  end

  def user_profile
    object.user_profile
  end

  def user_profile_name
    user_profile.name
  end

  def user_profile_avatar
    helpers.check_avatar user_profile
  end

  def relationship_form current_user
    return unless current_user
    helpers.ralationship_form current_user, object
  end

  def user_profile_gender
    UserProfile.human_enum_name :gender, :"#{user_profile.gender}"
  end

  def user_profile_birthday
    l user_profile.birthday, format: :date
  end

  def user_profile_phone
    user_profile.phone
  end

  def user_profile_address
    user_profile.address
  end
end
