Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :users
  resources :credit_cards
end
