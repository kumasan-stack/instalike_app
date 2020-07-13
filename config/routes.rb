Rails.application.routes.draw do
  devise_for :users, skip: :sessions,  path_names: { sign_up: 'signup' },
              controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    post   '/',             to: 'users/sessions#create',     as: :user_session
    delete 'logout',        to: 'users/sessions#destroy',    as: :destroy_user_session
    get    'edit/password', to: 'users/registrations#edit',  as: :edit_password_user_registration
  end
  root   "static_pages#home"
  get    "terms",          to: "static_pages#terms"
  get    "policy",         to: "static_pages#policy"
  resources :users,         only: [:index,  :show] do
    member do
      get :following, :followers
    end
  end
  resources :microposts,    only: [:new, :create, :destroy] do
    member do
      resources :comments,  only: [:create, :destroy]
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites,     only: [:create, :destroy]
end