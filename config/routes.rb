Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users do
    member do
      post :enable_multi_factor_authentication, to: 'users/multi_factor_authentication/multi_factor_authentication#verify_enable'
      # post :disable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_disabled'
    end
  end

  # get 'users/after_login', as: "users_after_login"

  scope "/admin" do
    resources :users
  end

  get 'two_factors/new', as: "two_factors_new"
  post 'two_factors/create', as: "two_factors_create"


  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'users/enable_otp'
  post 'users/allow_tfa'

  post 'users/verify_enabled'
  post 'users/verify_disabled'

  post 'users/disable_otp'
  post 'users/deny_tfa'
  root to: "users#index"
  # get '/user/dashboard' => "app#index", :as => :user_root
  
end
