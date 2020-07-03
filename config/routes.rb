Rails.application.routes.draw do
  devise_for :users, skip: :sessions,  path_names: { sign_up: 'signup' },
              controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get    'login',         to: 'devise/sessions#new',       as: :new_user_session
    post   'login',         to: 'devise/sessions#create',    as: :user_session
    delete 'logout',        to: 'devise/sessions#destroy',   as: :destroy_user_session
    get    'edit/password', to: 'devise/registrations#edit', as: :edit_password_user_registration
  end
  root   "static_pages#home"
  get    "/terms",          to: "static_pages#terms"
  get    "/policy",         to: "static_pages#policy"
  get    "/contact",        to: "static_pages#contact"
  resources :users,      only: [:index, :show]
  resources :microposts, only: [:create, :destroy]
end