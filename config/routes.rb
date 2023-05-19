Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions'
}

  root to: "home#index"

  resources :products, only: [:index, :new, :create, :show, :edit, :update]
  resources :auction_lots, only: [:index,:show, :new, :create, :edit, :update] do
    resources :product_items, only: [:new, :create, :destroy]
    resources :bids, only: [:create]
    post 'active', on: :member
    post 'closed', on: :member
    post 'cancel', on: :member
    get 'results', on: :collection
    get 'customer_results', on: :collection
    get 'search', on: :collection
  end
  resources :favorites, only: [:index, :create, :destroy]
  resources :blockeds, only: [:index, :new, :create, :destroy]
end
