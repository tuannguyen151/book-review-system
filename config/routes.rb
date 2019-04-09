Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    devise_for :users, controllers: {sessions: "users/sessions"},
      path: "", path_names: {sign_in: "login",
                             sign_out: "logout", edit: "edit", sign_up: "signup"}
    namespace :admin do
      root "home#index"
    end
    resources :books do
      resources :markers, only: %i(create destroy)
      resources :reviews
    end
    resources :purchase_requests, only: %i(index destroy)
    resources :favorites, only: %i(index destroy)
  end
end
