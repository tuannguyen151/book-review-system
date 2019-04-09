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
      get :autocomplete_book_title, on: :collection
    end
    resources :search_books, only: %i(index)
    resources :search_users, only: %i(index)
    resources :users, only: %i(show) do
      resources :relationships, only: %i(create destroy)
      get :autocomplete_user_profile_name, on: :collection
    end
    resources :purchase_requests, only: %i(index destroy)
    resources :favorites, only: %i(index destroy)
    resources :readed_books, only: %i(index destroy)
    resources :reading_books, only: %i(index destroy)
  end
end
