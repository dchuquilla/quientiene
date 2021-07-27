Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'home/index'
  get 'home/signup'
  
  #devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
