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
    resources :books, only: %i(index new create show edit update)
  end
end
