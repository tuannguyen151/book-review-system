module RelationshipsHelper
  def ralationship_form current_user, orther_user
    return if current_user == orther_user

    if current_user.following.include? orther_user
      render "users/unfollow", resource: orther_user
    else
      render "users/follow", resource: orther_user
    end
  end
end
