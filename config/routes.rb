Rails.application.routes.draw do
  get 'cart/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"
  resources :products, only: [:index, :show]
  get "/about", to: "pages#about"

  # Shopping Cart Routes
  get "cart", to: "cart#show"
  post "cart/add", to: "cart#add"
  post "cart/update", to: "cart#update"
  delete "cart/remove", to: "cart#remove"
end