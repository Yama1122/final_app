Rails.application.routes.draw do
  root :to 'products#index'
  resources :products
  resources :users
  resources :credit_cards
  resources 'searches', only: :index
end
