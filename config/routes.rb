Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  
  get 'home/index'
  get 'contact-us', to: 'home#contact_us'
  post 'contact-us', to: 'home#contact_us'
  get 'create', to: 'home#create'
  get 'privacy-policy', to: 'home#privacy_policy'
  get 'empresas', to: 'home#business'
  get 'dashboard', to: "dashboard#index"
  get 'dashboard_shop', to: "dashboard#shop"
  put 'users_add_onesignal_id', to: 'users#add_onesignal_id', defaults: { format: 'json' }
  get 'my_account', to: 'users#my_account'
  put 'update_account', to: 'users#update_account'
  
  #devise_for :users
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :replacement_requests do
    collection do
      get :closed
    end
    member do
      get :ignore
    end
  end
  resources :vehicles
  resources :shops
  resources :replacement_proposals do
    member do
      get :ignore
      get :accept
    end
  end
  defaults format: :json do
    get :search, to: 'replacement_proposals#search', as: 'replacement_proposal_search'
  end
end

