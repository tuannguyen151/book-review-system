class FavoritesController < ApplicationController
  authorize_resource class: Marker
  before_action :get_favorite, only: %i(destroy)

  def index
    @favorites = current_user.markers.created_at_desc
                             .where(status: :favorite).includes(:book)
  end

  def destroy
    if @marker.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".destroy_failure"
    end
    redirect_to favorites_path
  end

  private

  def get_favorite
    return if @marker = current_user.markers.find_by(id: params[:id])
    flash[:danger] = t ".favorite_not_found"
    redirect_to favorites_path
  end
end
