module MarkersHelper
  def marker_form book_id, status, user
    return unless user.instance_of? User
    if @marker = user.markers.find_by(book_id: book_id, status: status)
      render "markers/form/cancel_#{@marker.status}", object: @marker
    else
      render "markers/form/#{status}"
    end
  end

  def status_marker marker
    return unless marker.instance_of? Marker
    Marker.human_enum_name :status, :"#{marker.status}"
  end

  def check_favorite? book_id, user
    return true if user.markers.find_by(book_id: book_id, status: :favorite) &&
                   user.instance_of?(User)
  end
end
