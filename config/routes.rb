Rails.application.routes.draw do
  resources :shops
  root to: 'home#index'
  
  get 'home/index'
  get 'home/signup'
  get 'dashboard', to: "dashboard#index"
  get 'dashboard_shop', to: "dashboard#shop"
  
  #devise_for :users
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :replacement_requests
  resources :vehicles
end
