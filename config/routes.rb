Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"

  resources :products, only: [:index, :new, :create, :show]
  resources :auction_lots, only: [:index,:show, :new, :create, :edit, :update] do
    resources :product_items, only: [:new, :create, :destroy]
    resources :bids, only: [:new, :create]
  end
end
