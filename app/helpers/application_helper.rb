module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".book_review"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def navigation_activation *url_paths
    url_paths.each do |url_path|
      return "active" if request.original_fullpath == url_path
    end
  end
end
