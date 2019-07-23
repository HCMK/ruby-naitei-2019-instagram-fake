Rails.application.routes.draw do
  root "users#index"
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create", as: "sessions"
  get "logout", to: "sessions#destroy", as: "logout"
  resources :users
  resources :account_activations, only: :edit
end
