Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    devise_for :users, controllers: {sessions: "users/sessions"}
    namespace :admin do
      root "home#index"
    end
    resources :books, only: %i(index)
  end
end
