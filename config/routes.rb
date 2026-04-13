Rails.application.routes.draw do
  # Devise routes for Customers
  devise_for :customers
  
  # Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Resources
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :orders, only: [:index, :show]
  
  # Cart routes
  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: 'add_to'
    post 'remove/:product_id', to: 'carts#remove', as: 'remove_from'
    post 'update/:product_id', to: 'carts#update', as: 'update'
  end

  # Checkout routes (Requirement 3.3.1 & 3.3.2)
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Search routes
  get 'search', to: 'products#search', as: 'search_products'

  # Root page
  root "products#index"
end