Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
  end
end
