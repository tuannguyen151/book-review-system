Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    devise_for :users, controllers: {sessions: "users/sessions", registrations: "registrations"},
      path: "", path_names: {edit: "change_password", sign_up: "register"}
    namespace :admin do
      root "home#index"
    end
    resources :books do
      resources :markers, only: %i(create destroy)
      resources :reviews
      get :autocomplete_book_title, on: :collection
      collection do
        resources :favorites, only: %i(index destroy)
        resources :readed_books, only: %i(index destroy)
        resources :reading_books, only: %i(index destroy)
      end
    end
    resources :users, only: %i(show) do
      resources :relationships, only: %i(create destroy)
      get :autocomplete_user_profile_name, on: :collection
      resources :following, only: :index
      resources :followers, only: :index
      resources :user_profiles, only: %i(update)
    end
    resources :purchase_requests, path: "purchase-requests",
      only: %i(index destroy)
    resources :user_book_searches, only: :index
  end
end
