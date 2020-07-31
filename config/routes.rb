Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :logins

  scope "/admin" do
    resources :users
  end

  get 'two_factors/new', as: "two_factors_new"
  post 'two_factors/create', as: "two_factors_create"

  get '/logins', to: "logins#index"

  post 'users/enable_otp'
  post 'users/allow_tfa'

  post 'users/verify_enabled'
  post 'users/verify_disabled'

  post 'users/disable_otp'
  post 'users/deny_tfa'
  root to: "users#index"
  
end
