Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    namespace :api, {format: "json"} do
      namespace :v1 do
        namespace :admin do
          resources :books, only: :create
        end
        devise_scope :user do
          post "sign_in", to: "sessions#create"
          delete "sign_out", to: "sessions#destroy"
        end
        resources :users, only: %i(index show) do
          resources :following, only: :index
          resources :user_profiles, only: :update
        end
        resources :books, only: %i(index show)
      end
    end
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
        resources :book_filters, only: :index
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
