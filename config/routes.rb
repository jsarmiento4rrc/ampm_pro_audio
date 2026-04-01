Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :customers
  
  root "products#index"
  resources :products, only: [:index, :show]
  
  get "checkout", to: "checkout#index", as: "checkout"
  
  # Static Pages Routes
  get "about", to: "pages#about", as: "about"
  get "contact", to: "pages#contact", as: "contact"
end