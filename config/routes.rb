Rails.application.routes.draw do
  root   "static_pages#home"
  get    "/terms",   to: "static_pages#terms"
  get    "/policy",  to: "static_pages#policy"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  post   "/",        to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
end
