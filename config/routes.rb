Rails.application.routes.draw do
  devise_for :users
  root to:'products#index'
  resources :products
  resources :users do
    member do
      get 'logout'
    end
  end
  resources :credit_cards
  resources 'searches', only: :index
end
