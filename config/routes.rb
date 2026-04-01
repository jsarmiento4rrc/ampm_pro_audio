Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :customers
  
  root "products#index"
  resources :products, only: [:index, :show]
  
  # Add this specific route
  get "checkout", to: "checkout#index", as: "checkout"
end