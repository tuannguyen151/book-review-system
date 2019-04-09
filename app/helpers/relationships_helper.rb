module RelationshipsHelper
  def ralationship_form current_user, orther_user
    return if current_user == orther_user
    @user=orther_user

    if current_user.following.include? orther_user
      render partial: "users/unfollow", object: @user
    else
      render partial: "users/follow", object: @user
    end
  end
end
