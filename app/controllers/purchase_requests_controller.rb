class PurchaseRequestsController < ApplicationController
  authorize_resource class: Marker
  before_action :get_purchase_request, only: %i(destroy)

  def index
    @requests = current_user.markers.created_at_desc
                            .where(status: :purchase_request).includes(:book)
  end

  def destroy
    @marker.destroy
    flash[:success] = t ".success"
    redirect_to purchase_requests_path
  end

  private

  def get_purchase_request
    return if @marker = current_user.markers.find_by(id: params[:id])
    flash[:danger] = t ".purchase_request_not_found"
    redirect_to purchase_requests_path
  end
end
