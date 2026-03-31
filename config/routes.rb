Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "products#index"
  resources :products, only: [:index, :show]
  get "/about", to: "pages#about"
end