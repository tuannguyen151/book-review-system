class HomeController < ApplicationController
  def index
    return unless current_user
    activities = Activity.user_by(current_user.following)
                         .includes(user: :user_profile)
    marker_activites = activities.markers.includes(activitable: :book)
    relationship_activites = activities.relationships.includes(
      activitable: {followed: :user_profile}
    )
    @activities = Kaminari.paginate_array(
      (marker_activites + relationship_activites).sort_by(&:created_at).reverse
    ).page(params[:page]).per Settings.activites
  end
end
