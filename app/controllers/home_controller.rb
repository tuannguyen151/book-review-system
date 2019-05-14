class HomeController < ApplicationController
  def index
    return unless current_user
    activities = Activity.where_user(current_user.following)
                         .includes user: :user_profile
    marker_activites = activities.markers.includes activitable: :book
    relationship_activites = activities.relationships.includes(
      activitable: {followed: :user_profile}
    )
    activities = (marker_activites + relationship_activites)
                 .sort_by(&:created_at).reverse
    activities = ActivityDecorator.decorate_collection activities
    @activities = Kaminari.paginate_array(activities)
                          .page(params[:page]).per Settings.activites
  end
end
