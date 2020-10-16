Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # deviseにてusersを作成し使用する場合、controllers: {registrations: 'users/registrations'｝が必要
  root to:'products#index'
  # namespace :products do
  #   resources :searches, only: :index
  # end
  resources :products, only: [:index,:show,:new, :create, :destroy,:edit,:update] do
    member do
      get 'delete'
      get 'delete_done'
    end
    resources :purchases do
      member do
        get 'confirmation'
        post 'pay'
        get 'done'
      end
    end
  end
  
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'logout'
    end
    collection do
      get 'registration_select'
      get 'complete'
    end
  end

  resources :categories, only: [:index,:show] do
    collection do
      get :search
    end
  end
  
  resources :credit_cards, only: [:new,:show,:destroy,:create] do
    collection do
      get 'complete'
      get 'delete'
    end
  end
  resources :credit_cards, only: :new
  resources 'searches', only: :index
end

