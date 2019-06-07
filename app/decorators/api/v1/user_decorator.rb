class Api::V1::UserDecorator < Draper::Decorator
  delegate_all

  def user_profile_name
    object.user_profile.name
  end

  def user_profile_image
    return h.asset_url "icon/user.png" unless object.user_profile.avatar_url?
    h.asset_url object.user_profile.avatar_url_url
  end

  def user_profile_gender
    object.user_profile.gender
  end

  def user_profile_birthday
    object.user_profile.birthday
  end

  def user_profile_address
    object.user_profile.address
  end

  def user_profile_phone
    object.user_profile.phone
  end
end
