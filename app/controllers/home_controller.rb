class HomeController < ApplicationController
  def index
    return unless current_user
    @activities = Activity.order("created_at DESC")
                          .where(user_id: current_user.following)
                          .includes(:activitable, user: [:user_profile])
                          .page(params[:page]).per Settings.activites
  end
end
