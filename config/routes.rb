Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # deviseにてusersを作成し使用する場合、controllers: {registrations: 'users/registrations'｝が必要
  root to:'products#index'
  # productcpntrollerの直下にsearchescontorollerを作成した為namespaceメソッドを使用
  namespace :products do
    resources :searches, only: :index
  end
  resources :products, only: [:index,:show,:new, :create, :destroy,:edit,:update] do
    post 'add' => 'favorites#create'
    delete '/add' => 'favorites#destroy'
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
  
  resources :comments, only: [:create,:update,:destroy] do
    member do
      get 'restore'
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get 'logout'
      get 'favorites'
      get 'myproducts'
      get 'sold_myproducts'
      get 'buy_myproducts'

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
end

