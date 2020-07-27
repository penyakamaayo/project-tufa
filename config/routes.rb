Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  scope "/admin" do
    resources :users
  end

  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'users/enable_otp'
  post 'users/disable_otp'
  root to: "users#index"
  # get '/user/dashboard' => "app#index", :as => :user_root
  
end
