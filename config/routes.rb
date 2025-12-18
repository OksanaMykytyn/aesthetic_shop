Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: "users/sessions"
  }

  root "home#index"

  get "/catalog", to: "catalog#index"
  resources :products, only: [:show] do
    resources :reviews, only: [:create]
  end
  resource :profile, only: [:show]
  resource :checkout, only: [:show, :create]
  resources :orders, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :collections, only: [:index, :show]

  resource :cart, only: [:show] do
  post "add/:product_id", to: "cart_items#create", as: :add_item
  patch "update/:id", to: "cart_items#update", as: :update_item
  delete "remove/:id", to: "cart_items#destroy", as: :remove_item
end

namespace :admin do
  root to: "dashboard#show"
  resources :categories
  resources :collections
  resources :products
  resources :reviews, only: [:index, :destroy]
  resources :orders, only: [:index, :show, :update]

end
end
