Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :orders, only: [:index, :show]
  
  # Cart Routes
  resource :cart, only: [:show] do
    post 'add/:id', to: 'carts#add', as: 'add_to'
    post 'update/:id', to: 'carts#update', as: 'update'
    delete 'remove/:id', to: 'carts#remove', as: 'remove_from'
  end

  # Checkout Routes
  scope '/checkout' do
    get '/', to: 'checkout#index', as: 'checkout_index'
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Static Pages
  get 'about', to: 'pages#show', defaults: { permalink: 'about' }, as: 'about'
  get 'contact', to: 'pages#show', defaults: { permalink: 'contact' }, as: 'contact'
end