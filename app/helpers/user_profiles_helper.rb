module UserProfilesHelper
  def check_avatar user_profile
    return unless user_profile.instance_of? UserProfile
    user_profile.avatar_url? ? user_profile.avatar_url : "icon/user.png"
  end

  def gender user_profile
    return unless user_profile.instance_of? UserProfile
    UserProfile.human_enum_name :gender, :"#{user_profile.gender}"
  end
end
